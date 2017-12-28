require './clone_source_db_to_target_db'

clone_client = CloneSourceDbToTargettDb.new

puts "START!"

clone_client.make_data_directory("#{clone_client.filename['save_data_root_directory_name']}/#{clone_client.config_general['project_name']}")
clone_client.make_data_directory(clone_client.save_data_directory_name)
puts "MAKE DIRECTORIES DONE!"

clone_client.dump_source_db_table_structure
clone_client.dump_source_db_all_tables_data
puts "DUMP FROM SOURCE-DB DONE!"

clone_client.drop_target_db
clone_client.create_target_db
puts "RE-CREATE TARGET-DB DONE!"

clone_client.restore_table_structure_to_target_db
clone_client.insert_all_tables_data_to_target_db
puts "RESTORE TARGET-DB DONE!"
