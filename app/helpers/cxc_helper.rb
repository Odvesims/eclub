module CxcHelper
   require 'openssl'
   require 'base64'
  def documento_credito(pcons, ptipoid, pmotivoid,pmotivo_det, pcontrol, pnid, pfecha, pmonto, indic, pautom, puser)

                respon = {"opc" => "#{indic}"}
            respon["msgerror"] = ""

                @doc_ok = false
                #datos del cliente
                cte = Cliente.where("consorcio_id = #{pcons} AND nivel_id = #{pnid} AND nivel_control = '#{pcontrol}' ").first
                if cte == nil
                        respon["msgerror"] = merror(21,7)  #Cliente no existe
                        @responde = respon
                        return
                end

                tpdocum = Tipodocumento.where("id = #{ptipoid}").first
                if tpdocum == nil
                        respon["msgerror"] = merror(21,9)  #No existe el tipo de documento
                        @responde = respon
                        return
                end

                @razon = Motivo.where("id = #{pmotivoid}").first
                if @razon == nil
                        respon["msgerror"] = merror(21,10)  #No existe el motivo
                        @responde = respon
                        return
                end

                #cabecera del pago
                @cctransx = Cctransaccione.new
                @cctransx.consorcio_id = pcons
                @cctransx.fecha = pfecha

                @cctransx.documento_num = tpdocum.getSecuencia('A')
                @cctransx.tipo_doc = tpdocum.tipo_doc
                @cctransx.cliente_id = cte.id
		@cctransx.monto = pmonto
                @cctransx.tipodocumento_id = tpdocum.id
                @cctransx.motivo_id = @razon.id
                if pmotivo_det.empty?
                  @cctransx.detalle_motivo = @razon.descripcion
                else
                  @cctransx.detalle_motivo = pmotivo_det
                end
                @cctransx.tipo_control = pcontrol
                @cctransx.id_control = pnid
                @cctransx.dbcr = -1
                @cctransx.created_by = puser.login
                grupo_id  = 0
                rifero_id = 0
                banca_id  = 0
                sqlc = " "
                case pcontrol
                        when 'C'
                                grupo_id  = 0
                                rifero_id = 0
				banca_id  = 0
                        when 'G'
                            #modi = Rifero.where("consorcio_id = #{pcons} AND rifero_id = #{pnid}").first
                                grupo_id  = pnid
                                rifero_id = 0
                                banca_id  = 0
                                sqlc = " AND grupo_id = #{pnid} "
                        when 'R'
                                modi = Rifero.where("consorcio_id = #{pcons} AND rifero_id = #{pnid}").first
                                grupo_id  = modi.grupo_id
                                rifero_id = pnid
                                banca_id  = 0
                                sqlc = " AND rifero_id = #{pnid} "
                        when 'B'
                                modi = Banca.where("consorcio_id = #{pcons} AND banca_id = #{pnid}").first
                                grupo_id  = modi.grupo_id
                                rifero_id = modi.rifero_id
                                banca_id  = pnid
                sqlc = " AND banca_id = #{pnid} "
                end
		@cctransx.grupo_id  = grupo_id
                @cctransx.rifero_id = rifero_id
                @cctransx.banca_id  = banca_id
                @cctransx.save


                respon["tipo_doc"] = encrypta(tpdocum.descripcion,@algorithm,@llave)
                respon["documento_num"] = encrypta(@cctransx.documento_num.to_s,@algorithm,@llave)
                respon["monto"] = encrypta('%.2f' % @cctransx.monto,@algorithm,@llave)
                respon["cliente_nombre"] = encrypta(cte.nombre,@algorithm,@llave)
                respon["motivo_nombre"] = encrypta(@razon.descripcion,@algorithm,@llave)
                respon["fecha"] = encrypta(Date.today.strftime("%d-%m-%Y"),@algorithm,@llave)
                respon["hora"] = encrypta(Time.now.strftime("%H:%M:%S"),@algorithm,@llave)

                arrdeta = []

                #crea el documento
                la_referencia = hacereferencia(tpdocum.tipo_doc, @cctransx.documento_num, tpdocum.longitud_sec)

                @aplicado = 0
		 @queda = pmonto.to_f
                linea = 1
                #aplicar monto pendiente
                if pautom == true  #si hace aplicacion automatica....
                 @pendientes = Vtransaccionepend.where("consorcio_id = #{pcons} #{sqlc} AND det_monto > 0").all
                 @pendientes.each do |pend|
                        if @queda == 0
                                break
                        end
                        aplicar = pend.det_monto
                        if aplicar > @queda
                        aplicar = @queda
                        end
                        @aplicado += aplicar
                        @queda -= aplicar

                        @transdet = Cctransaccionesdet.new
                        @transdet.consorcio_id = pcons
                        @transdet.cctranscab_id = @cctransx.id
                        @transdet.linea = linea
			@transdet.fecha = pend.fecha
                        @transdet.fecha_vence = pend.fecha
                        @transdet.referencia_apl = pend.referencia_apl
                        @transdet.cctransaplica_id = pend.cctransaplica_id
                        @transdet.linea_apl = pend.linea_apl
                        @transdet.grupo_id = pend.grupo_id
                        @transdet.rifero_id = pend.rifero_id
                        @transdet.banca_id = pend.banca_id
                        @transdet.dbcr = -1
                        @transdet.monto = aplicar
                        @transdet.estatus_linea = 'A'
                        @transdet.modo_afecta = 'C'
                        @transdet.tipo_control = pcontrol
                        @transdet.id_control = pnid
                        @transdet.save

                        detresp = {"referencia" => encrypta(@transdet.referencia_apl,@algorithm,@llave)}
                        detresp["fecha"] = encrypta(@transdet.fecha.strftime("%d-%m-%Y"),@algorithm,@llave)
                        detresp["monto_det"] = encrypta('%.2f' % @transdet.monto,@algorithm,@llave)
			arrdeta[linea-1] = detresp
                        linea += 1
                  end #del each pendientes

            end ##del si aplica automatico

                if @queda > 0  #Si queda sin aplicar, aplicar al mismo documento
                        @transdet = Cctransaccionesdet.new
                        @transdet.consorcio_id = @consorcio_id
                        @transdet.cctranscab_id = @cctransx.id
                        @transdet.linea = 1
                        @transdet.fecha = @cctransx.fecha
                        @transdet.fecha_vence = @cctransx.fecha
                        @transdet.referencia_apl = la_referencia
                        @transdet.cctransaplica_id = @cctransx.id
                        @transdet.linea_apl = 1
                        @transdet.grupo_id = @cctransx.grupo_id
                        @transdet.rifero_id = @cctransx.rifero_id
                        @transdet.banca_id = @cctransx.banca_id
                        @transdet.dbcr = -1
			@transdet.monto = @queda
                        @transdet.estatus_linea = 'A'
                        @transdet.modo_afecta = 'C'
                        @transdet.tipo_control = pcontrol
                        @transdet.id_control = pnid
                        @transdet.save

                        detresp = {"referencia" => encrypta(@transdet.referencia_apl,@algorithm,@llave)}
                        detresp["fecha"] = encrypta(@transdet.fecha.strftime("%d-%m-%Y"),@algorithm,@llave)
                        detresp["monto_det"] = encrypta('%.2f' % @transdet.monto,@algorithm,@llave)

                        arrdeta[linea-1] = detresp
                end
                #actualizar el balance
                vmonto = pmonto.to_f*-1
                res = ActiveRecord::Base.connection.execute("SELECT set_balance_cxcbca(#{pcons},
                                                    #{grupo_id},#{rifero_id}, #{banca_id}, #{vmonto})")

                respon["detalle"] = arrdeta
                @responde = respon
		@doc_ok = true

        end  #del documento_credito


  #para registrar un documento debito
        def documento_debito(pdivem, ptipoid, pmotivoid, pcontrol, pnid, pfecha, pmonto, puser)
            respon = {"opc" => "06"}
            respon["msgerror"] = ""

                #datos del cliente
                cte = Cliente.where("id = #{pnid} ").first
                if cte == nil
                        respon["msgerror"] = merror(21,7)  #Cliente no existe
                        @responde = respon
                        return
                end

                tpdocum = Tipodocumento.where("divem_id = #{pdivem} AND id = '#{ptipoid}'").first
                if tpdocum == nil
                        respon["msgerror"] = merror(21,9)  #No existe el tipo de documento
                        @responde = respon
                        return
                end
		pdocumento_num = 1
		@recibo = Recibo.where("divem_id = #{pdivem}").last;
		if @recibo != nil
			pdocumento_num = @recibo.documento_num
		end
		@vendedor = Cobradore.where("usuario = '#{puser}'").first
		pvendedor_id = @vendedor.id
		motivo_id = pmotivoid
		@tipodoc = Tipodocumento.where("id = #{ptipoid}").first
		secuencia_ncf = Secuenciasncfdet.where("id = #{@tipodoc.ncf_id}").first
                @cliente = Cliente.where("id = #{pnid}").first
                ncf = @tipodoc.getNCFSecuencia('A', pfecha, @cliente.tipo_fiscal)
		numero_documento =  @tipodoc.getSecuencia('A')
		ActiveRecord::Base.connection.execute("INSERT INTO recibos_cab(divem_id, motivo_id, documento_num, cliente_id, fecha, vendedor_id,
									       monto_recibo, comentario, estatus_recibo, created_by, updated_by,
						    			       created_at, updated_at, tipodocumento_id, ncf)
						       VALUES(#{pdivem}, #{motivo_id}, '#{numero_documento}', #{pnid}, '#{pfecha}', 
							      #{pvendedor_id}, #{pmonto},'', 'A', '#{puser}',
							      '#{puser}', '#{Date.today}', '#{Date.today}', #{ptipoid}, '#{ncf}')")
		@recibo = Recibo.last
		motivo = Motivo.where("id = #{@recibo.motivo_id}").first
		respon["tipo_doc"] = encrypta(tpdocum.descripcion,@algorithm,@llave)
		respon["documento_num"] = encrypta(@recibo.documento_num.to_s,@algorithm,@llave)
		respon["monto"] = encrypta('%.2f' % @recibo.monto_recibo,@algorithm,@llave)
		respon["cliente_nombre"] = encrypta(@cliente.nombre_cliente,@algorithm,@llave)
		respon["motivo_nombre"] = encrypta(motivo.descripcion,@algorithm,@llave)
		respon["fecha"] = encrypta(Date.today.strftime("%d-%m-%Y"),@algorithm,@llave)
		respon["hora"] = encrypta(Time.now.strftime("%H:%M:%S"),@algorithm,@llave)
		arrdeta = []
		if @recibo == nil
			@recibo = 0
		else
			@recibo = @recibo.id
		end
		#Insertar Registro en CCTranscab#
		@cctranscab = Cctranscab.new
		@cctranscab.divem_id = pdivem
		@cctranscab.motivo_id = motivo_id
		@cctranscab.fecha = pfecha
		@cctranscab.documento_num = numero_documento
		@cctranscab.tipodocumento_id = @tipodoc.id
		@cctranscab.cliente_id = pnid
		motivo = Motivo.where("id = #{motivo_id}").first
		@cctranscab.detalle_motivo = motivo.descripcion
		@cctranscab.dbcr= '-1'
		@cctranscab.monto_bruto = pmonto
		@cctranscab.monto_desc = 0
		@cctranscab.monto_tax = 0
		@cctranscab.monto_neto = pmonto
		@cctranscab.estatus_doc = 'A'
		if @tipodoc.usa_ncf == 'S'
			secuencia_ncf = Secuenciasncfdet.where("id = #{@tipodoc.ncf_id}").first
			@cctranscab.ncf = ncf
		end
		@cctranscab.dias_vence = 0
		@cctranscab.created_by = puser
		@cctranscab.updated_by = puser
		@cctranscab.created_at = Date.today
		@cctranscab.updated_at = Date.today
		@cctranscab.save
		elCcTranscab = Cctranscab.where("divem_id = #{pdivem}").last
		transcab_id = elCcTranscab.id
		i = 0
		z = 1
		aplicado_a_mora = 0
		aplicado_a_interes = 0
		aplicado_a_capital = 0
		linea_capital = 0
		mto_pagare = ""
		abono_det = "" 
		res = ActiveRecord::Base.connection.execute("SELECT get_ccdistribuir_recibo(#{pdivem}, #{pnid}, #{pmonto}, '0', 2, 1)") 
		@detalles_cliente = Tmprecibodistribucion.all
		monto_recibo_total = pmonto.to_f 
		@detalles_cliente.each do |a|
			cc_trans_cab = Cctranscab.where("id = #{a.cctranscab_id}").first
			vcapital = nil
			vinteres = nil
			vmora = nil
			monto_capital = 0
			monto_interes = 0
			valor_saldado = 0
			capital_pendiente = 0
			interes_pendiente = 0
			valor_cuota = 0
			monto_mora = 0
			valor_mora = 0
			monto = a.abono.to_f
			monto_pendi = a.monto_pagare.to_f
			if monto.to_f > monto_pendi.to_f 
				monto_recibo_total -= a.abono.to_f
			else
				monto_recibo_total = 0
			end
			if monto.to_f > 0
				vmora = Cctransdet.where("cctranscab_id = #{a.cctranscab_id} AND linea_apl = #{a.pagare} AND modo_afecta = 'M'").first
				if vmora != nil			
					valor_mora = vmora.monto_neto.to_f
					if valor_mora > 0
						if monto.to_f > 0
							monto_mora = monto.to_f
						end
					end 
				end
				if monto_mora > 0
					monto_capital = 0
					monto_interes = 0
				else
					valor_capital = 0
					vcapital = Cctransdet.where("cctranscab_id = #{a.cctranscab_id} AND linea_apl = #{a.pagare} AND modo_afecta = 'C'").first
					if vcapital != nil
						valor_capital = vcapital.monto_neto.to_f
					end	
					valor_interes = 0
					vinteres = Cctransdet.where("cctranscab_id = #{a.cctranscab_id} AND linea_apl = #{a.pagare} AND modo_afecta = 'I'").first
					if vinteres != nil
						valor_interes = vinteres.monto_neto.to_f
					end
					logger.info("Valor Interes = " + valor_interes.to_s)
					valor_cuota = valor_capital + valor_interes
					capital_pendiente = valor_capital
					interes_pendiente = valor_interes
					valor_saldado = valor_cuota.to_f - monto_pendi.to_f							
					logger.info("Valor Cuota = " + valor_cuota.to_s)
					logger.info("Valor Pendiente = " + monto_pendi.to_s)
					logger.info("Valor Saldado = " + valor_saldado.to_s)
=begin
					if valor_saldado > 0
						if valor_saldado > valor_interes
							capital_pendiente = valor_capital - (valor_saldado - valor_interes)
							interes_pendiente = 0
						else
							capital_pendiente = valor_capital
							interes_pendiente = valor_interes - valor_saldado
						end
					end
=end
					if monto.to_f > interes_pendiente
						#monto_capital = monto.to_f - interes_pendiente
						monto_interes = monto.to_f - interes_pendiente
						if monto.to_f - monto_interes > 0
							monto_capital = monto.to_f - monto_interes 
						end
					else
						monto_capital = 0
						monto_interes = monto.to_f
					end
				end
				logger.info("Valor Capital = " + monto_capital.to_s)
				logger.info("Valor Interes = " + monto_interes.to_s)
				logger.info("Valor Mora = " + monto_mora.to_s)
				for vcaso in 1..3
					vmto_aplica = 0.00
					vmod_efecta = 'Vacio'
					case vcaso
						when 1
							vmto_aplica = monto_capital.to_f
							vmod_efecta = 'C'
							aplicado_a_capital += monto_capital
						when 2
							vmto_aplica = monto_interes.to_f
							vmod_efecta = 'I'
							aplicado_a_interes += monto_interes
						when 3
							vmto_aplica = monto_mora.to_f
							vmod_efecta = 'M'
							aplicado_a_mora += monto_mora
					end
					if vmto_aplica > 0
						@cctransdet = Cctransdet.new
						@cctransdet.cctranscab_id = transcab_id
						@cctransdet.linea = z
						@cctransdet.referencia_apl = a.doc + "-" + a.numero.to_s
						@cctransdet.cctransaplica_id = a.cctranscab_id
						@cctransdet.linea_apl = a.pagare
						@cctransdet.fecha_vence = a.fecha_vence
						@cctransdet.dbcr = '-1'
						@cctransdet.monto_bruto = vmto_aplica
						@cctransdet.monto_desc = 0
						@cctransdet.monto_tax = 0
						@cctransdet.monto_neto = vmto_aplica
						@cctransdet.estatus_linea = 'A'
						@cctransdet.modo_afecta = vmod_efecta.to_s
						@cctransdet.save
						detresp = {"referencia" => encrypta(@cctransdet.referencia_apl,@algorithm,@llave)}
						#detresp = {"pagare" => encrypta(a.pagare,@algorithm,@llave)}
						detresp["fecha"] = encrypta(@cctranscab.fecha.strftime("%d-%m-%Y"),@algorithm,@llave)
						detresp["monto_det"] = encrypta('%.2f' % @cctransdet.monto_bruto,@algorithm,@llave)
						arrdeta[i] = detresp
					end
				end
				z += 1
				i += 1
			end
		end
		ActiveRecord::Base.connection.execute("UPDATE recibos_cab SET aplicadoa_mora = #{aplicado_a_mora}, aplicadoa_capital = #{aplicado_a_capital}, aplicadoa_interes = #{aplicado_a_interes} WHERE id = #{@recibo}")
		monto_efectivo = pmonto
		@doc_afe_cja = @tipodoc.afecta_caja
		current_user = User.where("login = '#{puser}'").first 
		@user_caja = current_user.default_caja
		if @doc_afe_cja == 'S'
			if @user_caja != nil and @user_caja !=0
				cjtranscab = Cjtranscab.new
				cjtranscab.divem_id = pdivem
				cjtranscab.documento_num = numero_documento
				cjtranscab.tipodocumento_id = @tipodoc.id
				cjtranscab.caja_id = @user_caja
				divem = Divem.where("id = #{current_user.default_divem}").first
				if divem.divemscategoria_id == 1
					cjtranscab.modulo = 'P'
				elsif divem.divemscategoria_id == 2
					cjtranscab.modulo = 'I'
				else
					cjtranscab.modulo = 'S'
				end
				cjtranscab.fecha = pfecha
				cjtranscab.transacc_id = @cctranscab.id
				cjtranscab.monto = pmonto
				cjtranscab.save
				if monto_efectivo.to_f > 0
					cjtransformapago = Cjtransformapago.new
					cjtransformapago.forma_pago = 'EF'
					cjtransformapago.monto = monto_efectivo
					cjtransformapago.cjtranscab_id = cjtranscab.id
					cjtransformapago.save
				end
			end
		end


		#@razon = Motivo.where("id = #{pmotivoid}").first
		#if @razon == nil
                #        respon["msgerror"] = merror(21,10)  #No existe el motivo
                #        @responde = respon
                #        return
                #end
                respon["detalle"] = arrdeta
                @responde = respon
        end  #del documento_debito

 	def encrypta(msg, algorithm, key)
                begin
                        if @salta == 'f01c3'  #si salta el encrypt
                                return msg
                        else
                                cipher = OpenSSL::Cipher.new(algorithm)
                                cipher.encrypt()
                                cipher.key = key
                                crypt = cipher.update(msg) + cipher.final()
                                crypt_string = (Base64.encode64(crypt))
                                crypt_string = cambia_especiales(crypt_string,true) #cambia los especiales + => -, / => _, = => .
                                return crypt_string
                        end
                        rescue Exception => exc
                                puts ("Message for the encryption log file for message #{msg} = #{exc.message}")
                end
	end

	def desencrypta(msg,algorithm,key)
                begin
                        if @salta == 'f01c3'  #si salta el encrypt
                          return msg
                        else
                                msg = cambia_especiales(msg, false)
                                cipher = OpenSSL::Cipher.new(algorithm)
                                cipher.decrypt()
                                cipher.key = key
                                tempkey = Base64.decode64(msg)
                                crypt = cipher.update(tempkey)
                                crypt << cipher.final()
                                return crypt
                        end
                rescue Exception => exc
                        puts ("Message for the decryption log file for message #{msg} = #{exc.message}")
                end
        end

  #cambia los especiales + => -, / => _, = => .
        def cambia_especiales(txt, ind)
                ret = txt
                if ind == true
                        ret.gsub!("+","-")
                        ret.gsub!("/","_")
                        ret.gsub!("=",".")
                else
                        ret.gsub!("-","+")
                        ret.gsub!("_","/")
                        ret.gsub!(".","=")
                end
                return ret
        end

end  #del module

