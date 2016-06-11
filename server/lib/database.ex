require Amnesia
use Amnesia

defdatabase Database do
	deftable ChatLog, [{ :id, autoincrement }, :timestamp, :user, :message ], type: :ordered_set do
	end
end
