module BettyResource
  class Base
    # extend ActiveModel::Translation
    include HTTParty

    base_uri "#{BettyResource.config.host}/api"
    format :json
    basic_auth BettyResource.config.user, BettyResource.config.password

    # 
    # attr_accessor :attributes
    # class_inheritable_accessor :model_id
    # class_inheritable_accessor :form_id
    # class_inheritable_accessor :view_id
    # 
    # def initialize(attributes = {})
    #   replace_attributes(attributes)
    # end
    # 
    # def replace_attributes(attributes)
    #   attributes = hashify_attributes(attributes)
    # 
    #   @attributes = Hashr.new(attributes)
    # end
    # 
    # def hashify_attributes(attributes_to_hash)
    #   mappings = attributes_to_hash.collect do |key, value|
    #     keys = key.to_s.split(".")
    # 
    #     if keys.size == 1
    #       [key, value]
    #     else
    #       attributes_to_hash.delete(key)
    #       first = keys.shift
    # 
    #       val = keys.reverse.inject(value) do |v, path|
    #         {path => v}
    #       end
    #       [first, val]
    #     end
    #   end
    # 
    #   mappings.each do |key, value|
    #     attributes_to_hash[key] = value
    #   end
    # 
    #   attributes_to_hash
    # end
    # 
    # def id
    #   attributes["id"]
    # end
    # 
    # # Sets the <tt>\id</tt> attribute of the resource.
    # def id=(id)
    #   attributes["id"] = id
    # end
    # 
    # def to_json
    #   attributes.to_json
    # end
    # 
    # def method_missing(method_symbol, *arguments) #:nodoc:
    #   method_name = method_symbol.to_s
    # 
    #   if method_name =~ /(=|\?)$/
    #     case $1
    #     when "="
    #       attributes[$`] = arguments.first
    #     when "?"
    #       attributes[$`]
    #     end
    # 
    #   else
    #     return attributes[method_name] if attributes.include?(method_name.to_sym)
    #     # not set right now but we know about it
    #     super
    #   end
    # end
    # 
    # def save
    #   response = self.class.post "/models/#{self.class.model_id}/records/new?form_id=#{self.class.form_id}", :query => {:record => self.attributes}
    #   replace_attributes(response.parsed_response["record"])
    # end
    # 
    # class << self
    #   def paginate(options = {})
    #     page     = options.delete(:page) || 1
    #     per_page = options.delete(:per_page) || WillPaginate.per_page
    #     total    = options.delete(:total_entries)
    # 
    #     WillPaginate::Collection.create(page, per_page, total) do |pager|
    #       options[:limit] = pager.per_page
    #       options[:offset] = pager.offset
    # 
    #       find_result = find_for_pagination(options)
    # 
    #       pager.replace find_result.first
    #       pager.total_entries = find_result.last
    #     end
    #   end
    # 
    #   def find(scope, options = {})
    #     case scope
    #     when :all then find_every(options)
    #     when :first then find_every(options.merge(:limit => 1)).first
    #     else find_one(scope, options)
    #     end
    #   end
    # 
    #   def find_one(id, options = {})
    #     parameters = {:form_id => form_id}.merge(options)
    #     new(get("/models/#{model_id}/records/#{id}?#{parameters.to_param}").parsed_response["record"])
    #   end
    # 
    #   def find_every(options = {})
    #     find_for_pagination(options).first
    #   end
    # 
    #   def map_records(record_hashes)
    #     record_hashes.map{|record_hash| new(record_hash)}
    #   end
    # 
    #   def find_for_pagination(options = {})
    #     parameters = {:view_id => view_id, :limit => 100, :total_rows => true}.merge(options)
    #     parameters.merge!(:parent_record_id => options[:parent_id]) unless options[:parent_id].blank?
    # 
    #     result = get("/models/#{model_id}/records?#{parameters.to_param}")
    # 
    #     [map_records(result.parsed_response["records"]), result.parsed_response["total_rows"]]
    #   end
    # end
  end
end