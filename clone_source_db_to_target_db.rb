require 'mysql2'
require 'yaml'
require './dump_source_db'
require './restore_target_db'

class CloneSourceDbToTargetDb
  include DumpSourceDb
  include RestoreTargetDb

  attr_reader :config_general, :filename, :source_db, :target_db, :save_data_directory_name, :dump_source_db_structure_command

  def initialize
    config = YAML.load_file('config.yml')
    @config_general = config['general']
    @filename = config['filename']
    @source_db = config['source_db']
    @target_db = config['target_db']
    @save_data_directory_name = %Q(#{@filename['save_data_root_directory_name']}/#{@config_general['project_name']}/latest)
    @dump_source_db_structure_command = %Q(mysqldump -h#{@source_db['host']} -P#{@source_db['port']} -u#{@source_db['root_username']} -p#{@source_db['root_user_password']} --no-data #{@source_db['dbname']} > #{@save_data_directory_name}/#{@filename['structure_directory_name']}/#{@filename['structure_dump_fiilename']})
  end

  def table_names
    client = Mysql2::Client.new(
      host: @source_db['host'],
      port: @source_db['port'],
      username: @source_db['readonly_username'],
      password: @source_db['readonly_user_password'],
      database: @source_db['dbname'],
    )
    tables = client.query('SHOW TABLES');
    table_names = []
    tables.each do |table|
      table_names << table["Tables_in_#{@source_db['dbname']}"] # 予約語
    end
    table_names
  end

  def make_data_directory(directory_name)
    unless File.exist?(directory_name)
      command = %Q(mkdir #{directory_name})
      system command
    end
  end
end
