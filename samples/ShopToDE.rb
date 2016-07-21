require 'fuelsdk'
require 'shopify_api'
require 'sinatra'
require 'httparty'
require 'dotenv'
require_relative 'sample_helper'

appKey = "5d608b3305007dc4a0b26fdf8490ca2b"
appPassword = "7a18495d54b792e8df8cbdc9322d760b"
shop = "testpierry"

shop_url = "https://" + appKey + ":" + appPassword + "@" + shop + ".myshopify.com/admin/products.json"

response = HTTParty.get(shop_url)

p response["products"][0]


begin
	myclient = ET_Client.new auth

	# Example using CreateDataExtensions() method

	# Declare a Ruby Hash which contain all of the details for a DataExtension
	NTest_2 = {"Name" => "ShopifyTest","CustomerKey" => "ShopifyTest"}
	NTest_2['columns'] = [{"Name" => "Name", "FieldType" => "Text", "IsPrimaryKey" => "true", "MaxLength" => "100", "IsRequired" => "true"},{"Name" => "OtherField", "FieldType" => "Text"}]

	# Call CreateDataExtensions passing in both DataExtension Hashes as an Array
	createDEResponse = myclient.CreateDataExtensions([NTest_2])
	p 'CreateDataExtensions Status: ' + createDEResponse.status.to_s
	p 'Code: ' + createDEResponse.code.to_s
	p 'Message: ' + createDEResponse.message.to_s
	p 'Results Length: ' + createDEResponse.results.length.to_s
	p 'Results: ' + createDEResponse.results.to_s
  raise 'Failure creating data extensions' unless createDEResponse.success?

 	# Adding a row to the DE
	  dataextensionrow = FuelSDK::DataExtension::Row.new
	  dataextensionrow.authStub = myclient
	  dataextensionrow.Name = 'ShopifyTest'
	  dataextensionrow.props = {"Name" => response["products"][0]["title"], "OtherField" => response["products"][0]["vendor"]}
	  res = dataextensionrow.post
	  p res.results


rescue => e
	p "Caught exception: #{e.message}"
	p e.backtrace
end


