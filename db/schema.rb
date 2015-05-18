# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150518004959) do

  create_table "activity_log", force: :cascade do |t|
    t.datetime "time",                                                   null: false
    t.string   "item",               limit: 255
    t.string   "type",               limit: 255
    t.string   "event_id",           limit: 255
    t.string   "value_before",       limit: 75
    t.string   "value_after",        limit: 75
    t.string   "username",           limit: 200
    t.string   "network_controller", limit: 255
    t.integer  "datasource_id",      limit: 4
    t.string   "activity_type",      limit: 17,  default: "Unspecified"
    t.integer  "priority",           limit: 1,   default: 0
    t.integer  "duration",           limit: 2,   default: 0
    t.integer  "user_id",            limit: 3,                           null: false
    t.string   "comments",           limit: 255
  end

  add_index "activity_log", ["time"], name: "al_ts_ind", using: :btree

  create_table "alarms", primary_key: "alarm_id", force: :cascade do |t|
    t.boolean  "active",              limit: 1,   default: true, null: false
    t.integer  "event_enrollment_id", limit: 3,                  null: false
    t.integer  "datasource_id",       limit: 3,                  null: false
    t.integer  "status",              limit: 1
    t.integer  "priority",            limit: 2
    t.integer  "from_state",          limit: 2
    t.integer  "to_state",            limit: 2
    t.float    "value",               limit: 24
    t.integer  "ack_required",        limit: 1
    t.datetime "alarm_timestamp",                                null: false
    t.datetime "rec_timestamp",                                  null: false
    t.datetime "ack_timestamp"
    t.string   "alarm_user_id",       limit: 50
    t.string   "alarm_text",          limit: 256,                null: false
  end

  add_index "alarms", ["alarm_timestamp"], name: "alarms_alarm_timestamp", using: :btree
  add_index "alarms", ["datasource_id"], name: "alarms_ds_ind", using: :btree
  add_index "alarms", ["event_enrollment_id"], name: "alarms_event_enrollment_ind", using: :btree
  add_index "alarms", ["status", "ack_required"], name: "alarms_unack_ind", using: :btree

  create_table "auth_users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "hashed_password", limit: 255
    t.integer  "level",           limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "authusers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "hashed_password", limit: 255
    t.integer  "level",           limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "building_controller_history", id: false, force: :cascade do |t|
    t.integer  "controller_id",                limit: 4,               null: false
    t.integer  "event_id",                     limit: 4,   default: 0, null: false
    t.integer  "activity_type",                limit: 2,               null: false
    t.datetime "controller_history_timestamp",                         null: false
    t.integer  "user_id",                      limit: 3
    t.string   "description",                  limit: 256,             null: false
  end

  create_table "building_controllers", primary_key: "controller_id", force: :cascade do |t|
    t.integer  "site_id",                    limit: 4
    t.integer  "building_id",                limit: 4
    t.integer  "hardware_model_id",          limit: 4
    t.integer  "can_update",                 limit: 1
    t.integer  "controller_instance_number", limit: 3
    t.float    "calc_one",                   limit: 24
    t.float    "calc_two",                   limit: 24
    t.datetime "last_configured"
    t.datetime "last_rebooted"
    t.datetime "last_synchronized"
    t.string   "time_zone_offset",           limit: 6
    t.string   "ip",                         limit: 15
    t.string   "binary_version",             limit: 16
    t.string   "schema_version",             limit: 16
    t.string   "serial_number",              limit: 16
    t.string   "controller_name",            limit: 24
    t.string   "status",                     limit: 32
    t.string   "controller_reference",       limit: 96
    t.string   "controller_description",     limit: 256
    t.string   "rpt_name",                   limit: 128
    t.boolean  "active",                     limit: 1,   default: true
  end

  add_index "building_controllers", ["building_id"], name: "building_controller_building_id", using: :btree
  add_index "building_controllers", ["controller_instance_number"], name: "building_controller_instance_ind", using: :btree
  add_index "building_controllers", ["hardware_model_id"], name: "building_controller_model_ind", using: :btree

  create_table "buildings", primary_key: "building_id", force: :cascade do |t|
    t.integer  "building_number",      limit: 4,                   null: false
    t.integer  "site_id",              limit: 4,                   null: false
    t.boolean  "active",               limit: 1,   default: true
    t.boolean  "exterior_lighting",    limit: 1,   default: true
    t.boolean  "co2",                  limit: 1,   default: false
    t.boolean  "parking_security",     limit: 1,   default: false
    t.boolean  "metering",             limit: 1,   default: false
    t.integer  "square_footage",       limit: 4
    t.datetime "commission_date"
    t.string   "building_name",        limit: 128,                 null: false
    t.string   "building_description", limit: 256
    t.string   "address_line_1",       limit: 128
    t.string   "address_line_2",       limit: 128
    t.string   "city",                 limit: 128
    t.string   "state",                limit: 2
    t.string   "phone_number",         limit: 24
  end

  add_index "buildings", ["building_number"], name: "building_number", unique: true, using: :btree

  create_table "config", primary_key: "filenum", force: :cascade do |t|
    t.integer "filesize",             limit: 4, default: 0,  null: false
    t.integer "zippedsize",           limit: 4, default: 0,  null: false
    t.integer "site_instance_number", limit: 3, default: -1, null: false
    t.integer "type1",                limit: 2, default: -1, null: false
    t.integer "inst1",                limit: 3, default: -1, null: false
    t.integer "type2",                limit: 2, default: -1, null: false
    t.integer "inst2",                limit: 3, default: -1, null: false
    t.integer "type3",                limit: 2, default: -1, null: false
    t.integer "inst3",                limit: 3, default: -1, null: false
    t.integer "type4",                limit: 2, default: -1, null: false
    t.integer "inst4",                limit: 3, default: -1, null: false
    t.integer "type5",                limit: 2, default: -1, null: false
    t.integer "inst5",                limit: 3, default: -1, null: false
  end

  add_index "config", ["site_instance_number", "type1", "inst1", "type2", "inst2", "type3", "inst3", "type4", "inst4", "type5", "inst5"], name: "OBJECTKEY", using: :btree

  create_table "config_blobs", force: :cascade do |t|
    t.integer "filenum",  limit: 4,    default: 0, null: false
    t.binary  "filedata", limit: 8000,             null: false
  end

  add_index "config_blobs", ["filenum"], name: "DATABLOCKS", using: :btree

  create_table "controller_binaries", primary_key: "controller_binary_id", force: :cascade do |t|
    t.integer "controller_id",  limit: 4
    t.string  "binary_version", limit: 20
    t.string  "binary_name",    limit: 64
  end

  add_index "controller_binaries", ["controller_id"], name: "cont_bin_id_ind", using: :btree

  create_table "current_values", primary_key: "event_id", force: :cascade do |t|
    t.boolean  "active",              limit: 1,   default: true, null: false
    t.integer  "event_enrollment_id", limit: 3,                  null: false
    t.integer  "datasource_id",       limit: 3,                  null: false
    t.integer  "status",              limit: 1
    t.integer  "priority",            limit: 2
    t.integer  "from_state",          limit: 2
    t.integer  "to_state",            limit: 2
    t.float    "value",               limit: 24
    t.datetime "event_timestamp"
    t.datetime "rec_timestamp"
    t.string   "event_text",          limit: 200
  end

  add_index "current_values", ["datasource_id"], name: "current_values_ds_ind", using: :btree
  add_index "current_values", ["event_enrollment_id"], name: "current_values_event_ind", using: :btree
  add_index "current_values", ["event_timestamp"], name: "current_values_event_timestamp", using: :btree

  create_table "customer_data", primary_key: "customer_data_id", force: :cascade do |t|
    t.string "company_name", limit: 128
    t.string "company_desc", limit: 255
    t.string "address_1",    limit: 64
    t.string "address_2",    limit: 64
    t.string "state",        limit: 32
    t.string "country",      limit: 64
    t.string "zipcode",      limit: 15
    t.string "phone",        limit: 20
    t.string "uri",          limit: 64
  end

  create_table "database_connections", id: false, force: :cascade do |t|
    t.integer  "instance_count",         limit: 4,    default: 0
    t.integer  "elapsed_time_open",      limit: 8,    default: 0
    t.datetime "time_when_opened",                                 null: false
    t.datetime "time_when_closed",                                 null: false
    t.integer  "time_to_get_connection", limit: 8,    default: 0
    t.string   "sql",                    limit: 1024, default: ""
  end

  create_table "datasources", primary_key: "datasource_id", force: :cascade do |t|
    t.integer "controller_id",              limit: 4,    null: false
    t.integer "is_binary",                  limit: 1
    t.integer "device_id",                  limit: 4,    null: false
    t.integer "datasource_instance_number", limit: 3,    null: false
    t.integer "datasource_type",            limit: 2,    null: false
    t.string  "datasource_type_name",       limit: 48
    t.string  "datasource_property",        limit: 64
    t.string  "datasource_property_name",   limit: 64
    t.string  "datasource_reference",       limit: 128,  null: false
    t.string  "datasource_name",            limit: 24
    t.string  "units_description",          limit: 64
    t.string  "datasource_description",     limit: 1024
    t.string  "rpt_name",                   limit: 128
  end

  add_index "datasources", ["controller_id"], name: "datasources_cntrlr_id_ind", using: :btree
  add_index "datasources", ["datasource_instance_number"], name: "datasources_obj_instance_number_ind", using: :btree
  add_index "datasources", ["datasource_type"], name: "datasources_type", using: :btree
  add_index "datasources", ["device_id"], name: "datasources_device_id_ind", using: :btree

  create_table "diagnostic_trends_datasources", primary_key: "diag_trends_ds_id", force: :cascade do |t|
    t.boolean "active",              limit: 1,    null: false
    t.integer "state",               limit: 2
    t.integer "sample_rate",         limit: 2,    null: false
    t.integer "event_enrollment_id", limit: 3,    null: false
    t.integer "trend_set_id",        limit: 4,    null: false
    t.integer "datasource_id",       limit: 3,    null: false
    t.string  "name",                limit: 24
    t.string  "description",         limit: 1024
  end

  add_index "diagnostic_trends_datasources", ["trend_set_id", "event_enrollment_id", "datasource_id"], name: "diag_ts_event_ds_ind", unique: true, using: :btree

  create_table "equipment_objects", primary_key: "equipment_object_id", force: :cascade do |t|
    t.integer "equipment_object_instance_number", limit: 4,    null: false
    t.integer "controller_id",                    limit: 4,    null: false
    t.string  "equipment_object_name",            limit: 64,   null: false
    t.string  "equipment_object_description",     limit: 1024
    t.string  "equipment_object_reference",       limit: 128,  null: false
  end

  add_index "equipment_objects", ["controller_id"], name: "eo_cntrlr_id_ind", using: :btree

  create_table "equipment_properties", id: false, force: :cascade do |t|
    t.integer "equipment_object_id", limit: 4,   null: false
    t.string  "prop_name",           limit: 64,  null: false
    t.integer "prop_pos",            limit: 4,   null: false
    t.string  "prop_reference",      limit: 128, null: false
  end

  add_index "equipment_properties", ["equipment_object_id"], name: "ep_eo_id_ind", using: :btree

  create_table "event_enrollments", primary_key: "event_enrollment_id", force: :cascade do |t|
    t.integer "controller_id",         limit: 4,                  null: false
    t.integer "event_type",            limit: 2
    t.integer "event_instance_number", limit: 3
    t.string  "event_name",            limit: 24
    t.string  "event_description",     limit: 256
    t.string  "event_reference",       limit: 128
    t.string  "rpt_name",              limit: 128
    t.integer "catagory",              limit: 4,   default: 0
    t.boolean "active",                limit: 1,   default: true
    t.integer "notify_type",           limit: 4
  end

  add_index "event_enrollments", ["controller_id"], name: "event_enrollments_controller_ind", using: :btree
  add_index "event_enrollments", ["event_name"], name: "event_enrollments_event_name_ind", using: :btree

  create_table "events", primary_key: "event_id", force: :cascade do |t|
    t.boolean  "active",              limit: 1,   default: true, null: false
    t.integer  "event_enrollment_id", limit: 3,                  null: false
    t.integer  "datasource_id",       limit: 3,                  null: false
    t.integer  "status",              limit: 1
    t.integer  "priority",            limit: 2
    t.integer  "from_state",          limit: 2
    t.integer  "to_state",            limit: 2
    t.float    "value",               limit: 24
    t.datetime "event_timestamp",                                null: false
    t.datetime "rec_timestamp",                                  null: false
    t.string   "event_text",          limit: 200
  end

  add_index "events", ["datasource_id"], name: "events_ds_ind_5_7", using: :btree
  add_index "events", ["event_enrollment_id"], name: "events_event_enrollment_ind_5_7", using: :btree
  add_index "events", ["event_timestamp"], name: "events_event_timestamp_5_7", using: :btree

  create_table "group_relationships", id: false, force: :cascade do |t|
    t.integer "group_id",        limit: 4, null: false
    t.integer "group_member_id", limit: 4, null: false
  end

  add_index "group_relationships", ["group_id"], name: "group_relationships_id_ind", using: :btree
  add_index "group_relationships", ["group_member_id"], name: "group_relationships_member_ind", using: :btree

  create_table "groups", primary_key: "group_id", force: :cascade do |t|
    t.string   "group_name",          limit: 45
    t.string   "group_description",   limit: 1024
    t.integer  "group_type",          limit: 4
    t.string   "created_by_user_id",  limit: 50,   null: false
    t.datetime "created_timestamp",                null: false
    t.string   "modified_by_user_id", limit: 50
    t.datetime "modified_timestamp"
  end

  create_table "hardware_models", primary_key: "hardware_model_id", force: :cascade do |t|
    t.string "model_name",        limit: 64
    t.string "model_description", limit: 255
  end

  create_table "historical_trends", id: false, force: :cascade do |t|
    t.integer  "event_enrollment_id", limit: 3,  null: false
    t.integer  "datasource_id",       limit: 3,  null: false
    t.float    "value",               limit: 24, null: false
    t.datetime "trend_timestamp",                null: false
  end

  add_index "historical_trends", ["datasource_id"], name: "historical_trends_datasource_5_7", using: :btree
  add_index "historical_trends", ["event_enrollment_id"], name: "historical_trends_event_enrollment_5_7", using: :btree
  add_index "historical_trends", ["trend_timestamp"], name: "historical_trends_timestamp_5_7", using: :btree

  create_table "logical_devices", primary_key: "device_id", force: :cascade do |t|
    t.integer "hardware_model_id",      limit: 4
    t.integer "controller_id",          limit: 4
    t.integer "device_instance_number", limit: 3,   null: false
    t.integer "device_type",            limit: 2,   null: false
    t.integer "point_count",            limit: 2,   null: false
    t.float   "calc_one",               limit: 24
    t.float   "calc_two",               limit: 24
    t.string  "device_name",            limit: 64,  null: false
    t.string  "device_status",          limit: 32
    t.string  "device_type_name",       limit: 48,  null: false
    t.string  "device_reference",       limit: 128, null: false
    t.string  "device_description",     limit: 256
    t.string  "rpt_name",               limit: 128
  end

  add_index "logical_devices", ["controller_id"], name: "logical_devices_controller_ind", using: :btree
  add_index "logical_devices", ["device_type"], name: "logical_device_object_type_ind", using: :btree

  create_table "notes", primary_key: "note_id", force: :cascade do |t|
    t.string   "control_title",         limit: 64
    t.boolean  "active",                limit: 1,    default: true
    t.string   "control_reference",     limit: 120
    t.string   "object_reference",      limit: 120
    t.integer  "alt_id",                limit: 4,    default: 0
    t.datetime "created_time",                                      null: false
    t.string   "created_by_user_id",    limit: 50,                  null: false
    t.datetime "last_modified_time"
    t.string   "last_modified_user_id", limit: 50
    t.string   "title",                 limit: 70
    t.string   "description",           limit: 1024
  end

  create_table "notes_activity_log", force: :cascade do |t|
    t.integer  "note_id",              limit: 4,    null: false
    t.string   "action",               limit: 6,    null: false
    t.string   "previous_title",       limit: 70
    t.string   "previous_description", limit: 1024
    t.string   "new_title",            limit: 70
    t.string   "new_description",      limit: 1024
    t.datetime "activity_timestamp"
    t.string   "activity_user_id",     limit: 50
  end

  create_table "relaycost", id: false, force: :cascade do |t|
    t.string  "blockno",    limit: 30
    t.integer "relaycount", limit: 4
    t.float   "cost",       limit: 24
    t.float   "total",      limit: 24
    t.integer "instanceno", limit: 4
    t.string  "tenant",     limit: 40
    t.string  "suiteno",    limit: 20
  end

  create_table "reports", primary_key: "report_id", force: :cascade do |t|
    t.integer "sort_order",    limit: 4,    null: false
    t.string  "report_name",   limit: 64,   null: false
    t.string  "report_desc",   limit: 1024
    t.string  "report_uri",    limit: 256,  null: false
    t.string  "report_target", limit: 64,   null: false
    t.string  "report_group",  limit: 64
  end

  create_table "roles", primary_key: "role_id", force: :cascade do |t|
    t.boolean "permanent",   limit: 1,   default: false, null: false
    t.string  "description", limit: 255, default: "",    null: false
    t.string  "can_view",    limit: 255, default: "",    null: false
    t.string  "can_modify",  limit: 255, default: "",    null: false
    t.string  "can_create",  limit: 255, default: "",    null: false
    t.string  "can_delete",  limit: 255, default: "",    null: false
    t.string  "can_ack",     limit: 255, default: "",    null: false
  end

  create_table "rpt_description", primary_key: "desc_id", force: :cascade do |t|
    t.string "desc_1", limit: 64
    t.string "desc_2", limit: 64
    t.string "desc_3", limit: 64
    t.string "desc_4", limit: 64
    t.string "desc_5", limit: 64
    t.string "desc_6", limit: 64
  end

  create_table "servlet_log", id: false, force: :cascade do |t|
    t.integer  "uri_id",            limit: 3, null: false
    t.integer  "execution_time",    limit: 8, null: false
    t.datetime "request_timestamp",           null: false
  end

  add_index "servlet_log", ["execution_time"], name: "execution_time_ind", using: :btree
  add_index "servlet_log", ["request_timestamp"], name: "request_timestamp_ind", using: :btree
  add_index "servlet_log", ["uri_id"], name: "uri_id_fk_ind", using: :btree

  create_table "sites", primary_key: "site_id", force: :cascade do |t|
    t.integer  "site_instance_number", limit: 3,  null: false
    t.datetime "last_synchronized"
    t.string   "site_name",            limit: 24, null: false
  end

  create_table "state_transitions", force: :cascade do |t|
    t.string   "state_machine",       limit: 256, null: false
    t.string   "transition",          limit: 256, null: false
    t.integer  "max_memory",          limit: 8,   null: false
    t.integer  "total_memory",        limit: 8,   null: false
    t.integer  "free_memory",         limit: 8,   null: false
    t.float    "percent_free_memory", limit: 24,  null: false
    t.datetime "memory_timestamp",                null: false
  end

  create_table "subscription_sources", id: false, force: :cascade do |t|
    t.integer "subscription_id",            limit: 4
    t.string  "event_enrollment_reference", limit: 200
  end

  create_table "subscriptions", primary_key: "subscription_id", force: :cascade do |t|
    t.string "subscription_name",    limit: 255
    t.string "username",             limit: 255
    t.string "notification_service", limit: 255
    t.string "schedule_reference",   limit: 200
  end

  create_table "system_events", primary_key: "event_id", force: :cascade do |t|
    t.boolean  "active",      limit: 1,  null: false
    t.string   "name",        limit: 48, null: false
    t.integer  "type",        limit: 4,  null: false
    t.datetime "start"
    t.datetime "stop"
    t.datetime "last_update"
    t.integer  "state",       limit: 4
    t.string   "object_id",   limit: 96, null: false
    t.string   "user_id",     limit: 24, null: false
  end

  add_index "system_events", ["start"], name: "se_st_ind", using: :btree

  create_table "system_events_transaction", id: false, force: :cascade do |t|
    t.integer  "event_id",     limit: 4,               null: false
    t.boolean  "active",       limit: 1,               null: false
    t.datetime "event_time"
    t.integer  "state",        limit: 4
    t.string   "message",      limit: 128
    t.integer  "milliseconds", limit: 4,   default: 0
  end

  add_index "system_events_transaction", ["event_id"], name: "event_id", using: :btree
  add_index "system_events_transaction", ["event_time"], name: "set_et_ind", using: :btree

  create_table "tenantadd", id: false, force: :cascade do |t|
    t.string  "tenantname",   limit: 200
    t.integer "instanceno",   limit: 4
    t.string  "addressline1", limit: 150
    t.string  "addressline2", limit: 150
    t.string  "zipcode",      limit: 50
    t.string  "suiteno",      limit: 20
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "zip",        limit: 255
    t.text     "note",       limit: 65535
    t.string   "phone",      limit: 255
    t.float    "surcharge",  limit: 24
    t.integer  "manager_id", limit: 4
    t.string   "refnum",     limit: 255
    t.string   "suite",      limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "trend_sets", primary_key: "trend_set_id", force: :cascade do |t|
    t.boolean  "active",                      limit: 1,   null: false
    t.integer  "site_id",                     limit: 4
    t.integer  "default_chart_type",          limit: 1,   null: false
    t.integer  "default_display_time_period", limit: 4,   null: false
    t.datetime "created_time",                            null: false
    t.datetime "expiration_date",                         null: false
    t.datetime "last_modified_time",                      null: false
    t.datetime "default_display_start_time"
    t.string   "name",                        limit: 24,  null: false
    t.string   "description",                 limit: 256, null: false
    t.string   "created_by_user_id",          limit: 50,  null: false
    t.string   "last_modified_user_id",       limit: 50,  null: false
  end

  create_table "trends", id: false, force: :cascade do |t|
    t.integer  "event_enrollment_id", limit: 3,  null: false
    t.integer  "datasource_id",       limit: 3,  null: false
    t.float    "value",               limit: 24, null: false
    t.datetime "trend_timestamp",                null: false
  end

  add_index "trends", ["datasource_id"], name: "trends_datasource_5_7", using: :btree
  add_index "trends", ["event_enrollment_id"], name: "trends_event_enrollment_5_7", using: :btree
  add_index "trends", ["trend_timestamp"], name: "trends_timestamp_5_7", using: :btree

  create_table "uri_tracker", primary_key: "uri_id", force: :cascade do |t|
    t.string "uri",        limit: 256,  null: false
    t.string "query_path", limit: 1024
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string  "username",         limit: 255, default: "",    null: false
    t.string  "password",         limit: 255, default: "",    null: false
    t.string  "role_id",          limit: 255, default: "",    null: false
    t.string  "name",             limit: 255, default: "",    null: false
    t.string  "email",            limit: 255, default: "",    null: false
    t.string  "work_phone",       limit: 255, default: "",    null: false
    t.string  "mobile_phone",     limit: 255, default: "",    null: false
    t.string  "pager",            limit: 255, default: "",    null: false
    t.string  "fax",              limit: 255, default: "",    null: false
    t.string  "printer_name",     limit: 255, default: "",    null: false
    t.string  "computer_name",    limit: 255, default: "",    null: false
    t.string  "description",      limit: 255, default: "",    null: false
    t.string  "auto_logout",      limit: 255, default: "",    null: false
    t.string  "start_view",       limit: 255, default: "",    null: false
    t.boolean "permanent",        limit: 1,   default: false, null: false
    t.string  "explorer_refresh", limit: 255, default: "",    null: false
  end

  create_table "value_checker_details", primary_key: "detail_id", force: :cascade do |t|
    t.integer "summary_id",       limit: 4,   default: 0,                  null: false
    t.string  "object_type",      limit: 11,  default: "Value Point",      null: false
    t.string  "object_name",      limit: 250, default: "",                 null: false
    t.string  "property_name",    limit: 250, default: "",                 null: false
    t.string  "controller_value", limit: 250, default: "",                 null: false
    t.string  "server_value",     limit: 250, default: "",                 null: false
    t.string  "status",           limit: 26,  default: "Difference Noted", null: false
  end

  create_table "value_checker_jobs", primary_key: "job_id", force: :cascade do |t|
    t.integer  "site_instance_number",             limit: 4,  default: 0,                     null: false
    t.boolean  "ok_to_fix",                        limit: 1,  default: false,                 null: false
    t.datetime "time_started",                                default: '2000-01-01 13:00:00', null: false
    t.datetime "time_finished",                               default: '2000-01-01 13:00:00', null: false
    t.boolean  "finished",                         limit: 1,  default: false,                 null: false
    t.string   "group_name",                       limit: 75, default: "",                    null: false
    t.boolean  "look_for_controller_only_objects", limit: 1,  default: false,                 null: false
  end

  create_table "value_checker_summaries", primary_key: "summary_id", force: :cascade do |t|
    t.integer  "controller_id",     limit: 4,  default: 0,                     null: false
    t.integer  "job_id",            limit: 4,  default: 0,                     null: false
    t.string   "status",            limit: 12, default: "Not Started",         null: false
    t.integer  "value_point_count", limit: 4,  default: 0,                     null: false
    t.integer  "value_point_diffs", limit: 4,  default: 0,                     null: false
    t.integer  "schedule_count",    limit: 4,  default: 0,                     null: false
    t.integer  "schedule_diffs",    limit: 4,  default: 0,                     null: false
    t.datetime "time_started",                 default: '2000-01-01 13:00:00', null: false
    t.integer  "msecs_elapsed",     limit: 4,  default: 0,                     null: false
  end

  create_table "view_types", force: :cascade do |t|
    t.string  "domain",        limit: 255
    t.string  "friendly_name", limit: 255
    t.string  "link",          limit: 255
    t.boolean "can_view",      limit: 1
    t.boolean "can_modify",    limit: 1
    t.boolean "can_create",    limit: 1
    t.boolean "can_delete",    limit: 1
    t.boolean "can_ack",       limit: 1
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sqft",       limit: 4
    t.integer  "hour_limit", limit: 4
    t.integer  "meter_pct",  limit: 4
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "tenant_id",  limit: 4
    t.float    "rate",       limit: 24
  end

end
