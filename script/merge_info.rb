# merge info 4 tables to one
# around
AroundTmp.all.each do |item|
	p "transfer around #{item.id}"
	i = Information.new
	i.information_external = InformationExternal.new
	i.information_images = []
	i.title = item.title
	i.summary = item.summary
	i.context = item.context
	i.read = item.read
	i.like = item.like
	i.favorite = item.favorite
	i.admin_id = item.admin_id
	i.is_pending = item.is_pending
	i.visiable = item.visiable
	i.pending_reason = item.pending_reason
	i.created_at = item.created_at
	i.updated_at = item.updated_at

	i.information_external.source = item.source
	i.information_external.location = item.location
	i.information_external.contact = item.contact
	i.information_external.ticket_service = item.ticket_service
	i.information_external.has_ticket = item.has_ticket

	unless item.image.nil?
		im = InformationImage.new
		im.file = item.image
		i.information_images << im
	end

	item.around_images.each do |img|
		im = InformationImage.new
		im.file = img.file
		i.information_images << im
	end

	item.users_favorites.each do |u|
		i.users_favorites << u
	end

	item.users_likes.each do |u|
		i.users_likes << u
	end

	i.save
end