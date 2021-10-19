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
  def trains_type(type)
    self.trains.each do |train|
      if train.type == type
        puts train
      end
    end
  end
  
end





class Route

# имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними
  attr_accessor :station_list

  def initialize (first_station, last_station)
    @first_station = first_station
    @station_list = []
    @station_list.push(first_station)
    @station_list.push(last_station)
  end

  def new_station(station)
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

# имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  attr_accessor :speed, wagons, station

  def initialize(number, type, wagons, speed = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = speed
  end

# может набирать скорость и возвращать текущую скорость
  def speed=(speed)
    self.speed = speed
  end

# может тормозить (сбрасывать скорость до нуля)
  def stop
    self.speed = 0
  end

# может возвращать количество вагонов
  def wagons
    @wagons
  end

# может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется
  def add_wagons
     self.wagons +=1 if @speed == 0
  end

  def  delete_wagons
    self.wagons -=1 if @speed == 0 && wagons > 1
  end

# может принимать маршрут следования (объект класса Route), при назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
class Train < class Route
  self.station = @first_station
end

# может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз, возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def next_station
    self.station_list[self.station_list.index(self.station) + 1]
  end

  def prev_station
    self.station_list[self.station_list.index(self.station) - 1]
  end

  def current_station
    self.station_list[self.station_list.index(self.station)]
  end

end
