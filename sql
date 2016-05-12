SELECT
	(
		SELECT
			cc.parent_category_id
		FROM
			mdm_goods_category cc
		WHERE
			cc.category_id = a.category_id
	) AS pid,
	a.goods_code,
	a.goods_name
FROM
	mdm_goods_spec a
WHERE
	a.`status` = 0
AND a.category_id IN (
	SELECT
		b.category_id
	FROM
		mdm_goods_category b
	WHERE
		b.parent_category_id IN (
			SELECT
				c.category_id
			FROM
				mdm_goods_category c
			WHERE
				c.parent_category_id = 0
		)
	AND SUBSTR(a.goods_code, 1, 2) != b.parent_category_id
)
ORDER BY
	a.goods_code
