json.array!(@tasks) do |task|
  json.extract! task, :id, :task_name, :due_date, :weight, :progress, :priority, :required_time, :user_id
  json.url task_url(task, format: :json)
end
