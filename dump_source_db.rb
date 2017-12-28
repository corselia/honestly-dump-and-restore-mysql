module DumpSourceDb
  def dump_source_db_table_structure
    make_data_directory("#{@save_data_directory_name}/#{@filename['structure_directory_name']}")
    command = %Q(#{@dump_source_db_structure_command})
    system command
  end

  def dump_source_db_table_data(table_name)
    command = %Q(mysqldump -h#{@source_db['host']} -P#{@source_db['port']} -u#{@source_db['root_username']} -p#{@source_db['root_user_password']} --single-transaction #{@source_db['dbname']} #{table_name} > #{@save_data_directory_name}/#{@filename['table_data_directory_name']}/#{@filename['table_data_dump_filename_prefix']}.#{table_name}.dump)
    system command
  end

  def dump_source_db_all_tables_data
    make_data_directory("#{@save_data_directory_name}/#{@filename['table_data_directory_name']}")
    table_names.each do |table_name|
      puts "NOW DUMP #{table_name} TABLE..."
      dump_source_db_table_data(table_name)
    end
  end
end
