module RestoreTargetDb
  def drop_target_db
    command = %Q(mysql -h#{@target_db['host']} -P#{@target_db['port']} -u#{@target_db['root_username']} -p#{@target_db['root_user_password']} -e'DROP DATABASE #{@target_db['dbname']};')
    system command
  end

  def create_target_db
    command = %Q(mysql -h#{@target_db['host']} -P#{@target_db['port']} -u#{@target_db['root_username']} -p#{@target_db['root_user_password']} -e'CREATE DATABASE #{@target_db['dbname']};')
    system command
  end

  def restore_table_structure_to_target_db
    command = %Q(mysql -h#{@target_db['host']} -P#{@target_db['port']} -u#{@target_db['root_username']} -p#{@target_db['root_user_password']} -D #{@target_db['dbname']} < #{latest_dirctory_name("#{@filename['save_data_root_directory_name']}/#{@config_general['project_name']}")}/#{@filename['structure_directory_name']}/#{@filename['structure_dump_fiilename']})
    system command
  end

  def insert_all_tables_data_to_target_db
    table_names.each do |table_name|
      puts "NOW INSERT #{table_name} TABLE..."
      insert_table_data_to_target_db(table_name)
    end
  end

  def insert_table_data_to_target_db(table_name)
    command = %Q(mysql -h#{@target_db['host']} -P#{@target_db['port']} -u#{@target_db['root_username']} -p#{@target_db['root_user_password']} -D #{@target_db['dbname']} < #{latest_dirctory_name("#{@filename['save_data_root_directory_name']}/#{@config_general['project_name']}")}/#{@filename['table_data_directory_name']}/#{@filename['table_data_dump_filename_prefix']}.#{table_name}.dump)
    system command
  end
end
