json.array!(@bids) do |bid|
  json.extract! bid, :id, :bidding, :user_id, :item_id
  json.url bid_url(bid, format: :json)
end
