categories = [
  ["آلات الطباعة", "printing-machines", "معدات إنتاج احترافية للمطابع والأعمال الكبيرة."],
  ["الطابعات", "printers", "طابعات مكتبية وتجارية لأداء يومي ثابت."],
  ["الأحبار والتونر", "inks-toner", "مواد استهلاكية أصلية لألوان دقيقة ونتائج واضحة."],
  ["قطع الغيار", "spare-parts", "قطع موثوقة للحفاظ على كفاءة معداتك."],
  ["مستلزمات الطباعة", "supplies", "كل التفاصيل التي تكمل تجربة الطباعة."]
]
categories.each { |name, slug, description| Category.find_or_create_by!(slug: slug) { |record| record.name = name; record.description = description } }

["HP", "Canon", "Epson", "Xerox"].each { |name| Brand.find_or_create_by!(slug: name.downcase) { |record| record.name = name } }

products = [
  ["طابعة HP Color LaserJet Pro", "hp-color-laserjet-pro", "طباعة لونية احترافية بسرعة واعتمادية عالية.", "HP", "الطابعات", true],
  ["ماكينة Xerox VersaLink", "xerox-versalink", "حل إنتاجي متكامل للمكاتب وبيئات العمل.", "Xerox", "آلات الطباعة", true],
  ["حبر Canon أصلي", "canon-original-ink", "ألوان غنية وتفاصيل دقيقة مع كل صفحة.", "Canon", "الأحبار والتونر", false],
  ["طابعة Epson WorkForce", "epson-workforce", "كفاءة عالية للأعمال اليومية والطباعة المستمرة.", "Epson", "الطابعات", true]
]
products.each do |name, slug, description, brand_name, category_name, featured|
  product = Product.find_or_initialize_by(slug: slug)
  product.assign_attributes(name: name, short_description: description, description: description, model_number: slug.upcase, brand: Brand.find_by(name: brand_name), category: Category.find_by(name: category_name), active: true, featured: featured)
  product.save!
end

SiteSetting.find_or_create_by!(key: "whatsapp_number") { |setting| setting.value = ENV.fetch("WHATSAPP_NUMBER", "966500000000") }

if ENV["ADMIN_EMAIL"].present? && ENV["ADMIN_PASSWORD"].present?
  Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) { |admin| admin.password = ENV["ADMIN_PASSWORD"] }
end
