CREATE OR REPLACE FUNCTION get_hojasevaluacion(pcamporee_id integer, pevento_id integer)
	RETURNS integer
	LANGUAGE plpgsql
	AS $function$
		DECLARE
		pcamporee_id    ALIAS FOR $1;
		pevento_id    ALIAS FOR $2;
	BEGIN
		CREATE TEMPORARY TABLE IF NOT EXISTS tmp_eventocabezera(camporee_id integer, evento_id integer, renglon_id integer, 
														   evento_nombre character varying, participantes character varying, tiempo character varying, total_puntos numeric(10,2), renglon_nombre character varying);
	 
		TRUNCATE tmp_eventocabezera;
		
		CREATE TEMPORARY TABLE IF NOT EXISTS tmp_eventocriterios_cab(camporeesevento_id integer, camporeeseventoscriterioscab_id integer, criterio_nombre character varying, puntos_criterio_cab numeric(10,2));
	 
		TRUNCATE tmp_eventocriterios_cab;
		
		CREATE TEMPORARY TABLE IF NOT EXISTS tmp_eventocriterios_dets(camporeeseventoscriterioscab_id integer, evento_id integer, detalle_nombre character varying, puntos_criterio_det numeric(10,2));
	 
		TRUNCATE tmp_eventocriterios_dets;
		
		INSERT INTO tmp_eventocabezera SELECT pcamporee_id, e.id, r.id, e.nombre, e.participantes, e.tiempo, e.total_puntos, r.nombre
		FROM camporeeseventos e, camporeesrenglones r
		WHERE e.camporee_id = pcamporee_id AND (pevento_id = 0 OR e.id = pevento_id)
		AND r.id = e.camporeesrenglone_id;
		
		INSERT INTO tmp_eventocriterios_cab SELECT c.camporeesevento_id, c.id, c.nombre, c.total_puntos
		FROM camporeeseventoscriterioscabs c
		WHERE c.camporee_id = pcamporee_id AND (pevento_id = 0 OR c.camporeesevento_id = pevento_id);
		
		INSERT INTO tmp_eventocriterios_dets SELECT d.camporeeseventoscriterioscab_id, d.camporeesevento_id, d.nombre, d.puntos
		FROM camporeeseventoscriteriosdets d
		WHERE d.camporee_id = pcamporee_id AND (pevento_id = 0 OR d.camporeesevento_id = pevento_id);
		
		RETURN 1;
END
$function$