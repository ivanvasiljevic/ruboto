require File.expand_path("test_helper", File.dirname(__FILE__))
require 'fileutils'

class RubotoGenTest < Test::Unit::TestCase
  def setup
    Dir.mkdir TMP_DIR unless File.exists? TMP_DIR
    FileUtils.rm_rf APP_DIR if File.exists? APP_DIR
  end

  def teardown
    # FileUtils.rm_rf APP_DIR if File.exists? APP_DIR
  end

  def test_plain_gen
    system "jruby -rubygems -I #{PROJECT_DIR}/lib #{PROJECT_DIR}/bin/ruboto gen app --package #{PACKAGE} --path #{APP_DIR} --name #{APP_NAME} --min_sdk #{ANDROID_TARGET}"
    assert_equal 0, $?, "gen app failed with return code #$?"
  end

  if not ON_JRUBY_JARS_1_5_6
    def test_gen_with_psych
      system "jruby -rubygems -I #{PROJECT_DIR}/lib #{PROJECT_DIR}/bin/ruboto gen app --package #{PACKAGE} --path #{APP_DIR} --name #{APP_NAME} --min_sdk #{ANDROID_TARGET} --with-psych"
      assert_equal 0, $?, "gen app failed with return code #$?"
      assert File.exists?("#{APP_DIR}/libs/psych.jar"), "Failed to generate psych jar"
    end
  else
    puts "Skipping Psych tests on jruby-jars-1.5.6"
  end

end