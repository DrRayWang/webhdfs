require 'test_helper'

class WebHDFSTest < Test::Unit::TestCase
  def setup
    require 'webhdfs'
    require 'webhdfs/client_v1'
    host = 'host'
    port = '00000'
    user = 'hdfs'
    @owner1 = 'owner1'
    @owner2 = 'owner2'
    @owner3 = 'owner3'
    @group1 = 'hdfs'
    @group2 = 'supergroup'
    @group3 = 'hdfs'
    @path = '/user/tmp/tmp'
    @root = '/user/tmp'
    @client = WebHDFS::Client.new(host,port,user)
  end

  def test_chmod_with_recursive_true
    puts "Test for test_chmod_with_recursive_true"
    @client.mkdir(@path)
    @client.chmod(@root,:permission => "600", :recursive => true)
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['permission'],submeta['permission'])
  end

  def test_chmod_with_recursive_false
    puts "Test for test_chmod_with_recursive_false"
    @client.mkdir(@path)
    @client.chmod(@root,:permission => "644", :recursive => false)
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['permission'],"644")
    refute_equal(submeta['permission'],"644")
  end

  def test_chmod_without_recursive
    puts "Test for test_chmod_without_recursive"
    @client.mkdir(@path)
    @client.chmod(@root,:permission => "700")
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['permission'], "700")
    refute_equal(submeta['permission'], "700")
  end

  def test_chown_with_recursive_true
    puts "Test for test_chown_with_recursive_true"
    @client.mkdir(@path)
    @client.chown(@root, :owner => @owner1, :group => @group1, :recursive => true)
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['owner'], @owner1)
    assert_equal(submeta['owner'], @owner1)
    assert_equal(rootmeta['group'], @group1)
    assert_equal(submeta['group'], @group1)
  end 

  def test_chown_with_recursive_false
    puts "Test for test_chown_with_recursive_false"
    @client.mkdir(@path)
    @client.chown(@root, :owner => @owner2, :group => @group2, :recursive => false)
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['owner'], @owner2)
    refute_equal(submeta['owner'], @owner2)
    assert_equal(rootmeta['group'], @group2)
  end

  def test_chown_without_recursive
    puts "Test for test_chown_without_recursive"
    @client.mkdir(@path)
    @client.chown(@root, :owner => @owner3, :group => @group3)
    rootmeta = @client.stat(@root)
    submeta = @client.stat(@path)
    @client.delete(@root, :recursive => true)
    assert_equal(rootmeta['owner'], @owner3)
    refute_equal(submeta['owner'], @owner3)
    assert_equal(rootmeta['group'], @group3)
    refute_equal(submeta['group'], @group3)
  end 

end

