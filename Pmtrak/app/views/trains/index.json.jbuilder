json.array! @trains, partial: "trains/train", as: :train
json.seats_left train.train_capacity - train.tickets.count
