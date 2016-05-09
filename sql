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
	
	
	select
        o.order_id as orderId,
        o.order_code as orderCode,
        o.create_time as createTime,
        o.order_source as orderSource,
        o.receiver_address as receiverAddress,
        o.receiver_name as receiverName,
        o.receiver_phone as receiverPhone,
        case o.order_source 
            when 0 then '安卓APP' 
            when 1 then '苹果APP' 
            when 2 then '客服中心' 
            when 3 then 'Web商城' 
            else '全部' 
        end as orderSourceString,
        (select
            b.deliver_user_name 
        from
            om_order_deliver b  
        where
            b.deliver_id =(
                select
                    max(a.deliver_id) 
                from
                    om_order_deliver a 
                where
                    a.order_id=o.order_id
										AND a.deliver_user_id = 349
            )
        ) as deliverUserName,o.create_user_name as operatorName,o.order_status as orderStatus, case o.order_status 
            when 0 then '已下单' 
            when 10 then '已下单' 
            when 11 then '已下单' 
            when 20 then '已下单' 
            when 21 then '已备货' 
            when 34 then '已取消'  
            when 30 then '已备货' 
            when 31 then '已备货' 
            when 32 then '派送中' 
            when 33 then '派送中' 
            when 90 then '订单完成' 
            when 95 then '已取消' 
            else '' 
        end as orderStatusString 
    from
        om_order o 
    where
        1=1  
        and o.order_id in (
            SELECT
                b.order_id 
            FROM
                ( SELECT
										 d.order_id,
                    -- max(d.deliver_id),
                     d.deliver_user_id  
                FROM
                    om_order_deliver d 
								WHERE d.deliver_user_id = 349
                    ) AS b) 
            order by
                o.create_time desc 
