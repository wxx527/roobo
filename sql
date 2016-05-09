SELECT
	gc.category_id,
	gc.parent_category_id,
	gc.category_name,
	(
		SELECT
			count(DISTINCT sg.instance_id)
		FROM
			mdm_store_goods sg,
			mdm_goods_spec gs
		WHERE
			sg.spec_id = gs.spec_id
		AND gs.category_id = gc.category_id
		AND sg.`status` = 1
		AND sg.store_id = 98
	) AS cc
FROM
	mdm_goods_category gc
