# Normally, an OpenStruct will include a "table" root in the JSON
# and this is not desired behavior, so we strip it by over-riding
class DataStruct < OpenStruct
  def as_json(*args)
    super.as_json['table']
  end
end
