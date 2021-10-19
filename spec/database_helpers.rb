require 'pg'

def persisted_data(table:, id:)
  connection = PG.connect(dbname: 'makersbnb_test')
  result = connection.exec("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end

def create_host
  connection = PG.connect(dbname: 'makersbnb_test')
  host_user_result = connection.exec(
    "INSERT INTO users(first_name, last_name, email, password, host)
    VALUES('Guest', 'User', 'test@example.com', '12345', 'true') RETURNING *;"
  )
  host_user_result[0]['id']
end

def create_bnb(host)
  connection = PG.connect(dbname: 'makersbnb_test')
  bnb_result = connection.exec(
    "INSERT INTO bnbs(name, location, price, user_id)
    VALUES('Test BNB', 'London', '30', '#{host_user_id}') RETURNING *;"
  )
  bnb_result[0]['id']
end
