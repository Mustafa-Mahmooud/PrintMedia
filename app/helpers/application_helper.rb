module ApplicationHelper
	def whatsapp_number
		SiteSetting.fetch("whatsapp_number", ENV.fetch("WHATSAPP_NUMBER", "966500000000"))
	end

	def whatsapp_link(product = nil)
		message = product ? "مرحباً Print Media، أود الاستفسار عن #{product.name}" : "مرحباً Print Media، أود معرفة المزيد عن منتجاتكم"
		"https://wa.me/#{whatsapp_number}?text=#{ERB::Util.url_encode(message)}"
	end

	def product_image(product, classes: "")
		if product.image.attached?
			image_tag product.image, class: classes, alt: product.name
		else
			image_tag "https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?auto=format&fit=crop&w=900&q=85", class: classes, alt: product.name
		end
	end
end
