#require Amnesia
use Amnesia

defdatabase Data do
	deftable ChatLog, [{ :id, autoincrement }, :timestamp, :message ], type: :ordered_set do
	end
end

defmodule Database do
	use Data

	def setup() do
		Amnesia.Schema.create
		Amnesia.start
		Data.create(disk: [node])
		Data.wait
	end

	def history() do
		Amnesia.transaction do
			 ChatLog.where(true, select: message).values
		end
	end

	def append(message) do
		Amnesia.transaction do
			%ChatLog{timestamp: 0, message: message} |> ChatLog.write
		end
	end
end
