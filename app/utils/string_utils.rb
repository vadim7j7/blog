class StringUtils
  class << self
    # @param [String] str
    def str_to_slug(str)
      return '' if str.blank?

      str.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '').gsub(/-{2,}/, '-')
    end

    # @param [Object] obj
    # @param [String] txt
    # @param [Integer, NilClass] id
    # @return [String]
    def unique_slug(obj, txt, id = nil)
      slug    = str_to_slug(txt)
      handler = obj.where('slug LIKE ?', "#{slug}%").order(created_at: :desc)
      handler = handler.where.not(id: id) unless id.nil?
      item    = handler.first
      if item.present?
        last_num = item.slug.split('-')[-1].to_i
        slug = "#{slug}-#{(last_num + 1)}"
      end
      slug.gsub(/-{2,}/, '-')
    end
  end
end
