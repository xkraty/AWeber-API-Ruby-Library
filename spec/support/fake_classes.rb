class FakeResource < AWeber::Resource
  attr_accessor :foo
  basepath "/fakes"
  api_attr :name, :writable => true
  alias_attribute :bar, :foo
  has_many :lists
end

class FakeParent < AWeber::Resource
  basepath "/parents"
end

class FakeChild < AWeber::Resource
  basepath "/children"
end