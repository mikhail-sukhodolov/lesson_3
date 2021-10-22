class Station

# имеет название, которое указывается при ее создании
# может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name
  attr_reader :trains

  def initialize (name)
    @name = name
    @trains = []
  end

# может принимать поезда (по одному за раз)
  def get_train(train)
    self.trains.push(train)
  end

# может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def departure(train)
    self.trains.delete(train)
  end

# может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def get_type(type)
	  @trains.select {|train| train.type == type}            
	end
end





class Route

# имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними
  attr_accessor :station_list

  def initialize (first_station, last_station)
    @station_list = [first_station, last_station]
  end

  def add_station(station)
    self.station_list.push(station)
  end

# может удалять промежуточную станцию из списка
  def delete_station(station)
    self.station_list.delete(station)
  end

# может выводить список всех станций по-порядку от начальной до конечной
  def all_station
    puts @station_list
  end
end





class Train

# имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса, может набирать скорость и возвращать текущую скорость, может возвращать количество вагонов

  attr_accessor :speed, :station, :route
  attr_reader :wagons


  def initialize(number, type, wagons, speed = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = speed
  end

# может тормозить (сбрасывать скорость до нуля)
  def stop
    self.speed = 0
  end

# может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется
  def add_wagons
     self.wagons +=1 if @speed == 0
  end

  def  delete_wagons
    self.wagons -=1 if @speed == 0 && wagons > 1
  end

# может принимать маршрут следования (объект класса Route), при назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def add_route(route)
     self.station = self.route.station_list.first
  end
    
# может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз, возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def next_station
    self.station_list[self.route.station_list.index(self.station) + 1]
  end

  def prev_station
    self.station_list[self.route.station_list.index(self.station) - 1]
  end

  def current_station
    self.station_list[self.route.station_list.index(self.station)]
  end
end
