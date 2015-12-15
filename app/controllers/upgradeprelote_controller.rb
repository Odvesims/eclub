class UpgradepreloteController < ActionController::Base
  respond_to :json
        def index
                prelote = Preloteaplicacion.first

                el_jason = Array.new

                if prelote == nil
                        controles = {}
                        controles["valid"] = "false"
                        prelote_arr = Array.new
                        hash = {}
                        prelote_arr.push(hash)
                        controles["prelote"] = prelote_arr
                else
                        controles = {}
                        controles["valid"] = "true"
                        prelote_arr = Array.new
                                hash = {}
                                hash["id"] = prelote.id
                                hash["version_actual"] = prelote.version_actual.to_s
                                hash["url_actual"] = prelote.url_actual
                                hash["version_anterior"] = prelote.version_anterior.to_s
                                hash["url_anterior"] = prelote.url_anterior
                                hash["comentarios"] = prelote.comentarios
                                prelote_arr.push(hash)
                        controles["prelote"] = prelote_arr
                end
                el_jason.push(controles)
                JSON.generate(controles)
                render :text => JSON.generate(controles)
        end
		
		 def show
                prelote = Preloteaplicacion.first

                el_jason = Array.new

                if prelote == nil
                        hash = [[[]]]
                        el_jason.push(hash)
                else
                        hash = {}
                        hash["id"] = prelote.id
                        hash["version_actual"] = prelote.version_actual.to_s
                        hash["url_actual"] = prelote.url_actual
                        hash["version_anterior"] = prelote.version_anterior.to_s
                        hash["url_anterior"] = prelote.url_anterior
                        hash["comentarios"] = deb.comentarios
                        el_jason.push(hash)

                end
                JSON.generate(el_jason)
                render :text => JSON.generate(el_jason)
        end
		
		def create
        end

        def edit
        end
end

