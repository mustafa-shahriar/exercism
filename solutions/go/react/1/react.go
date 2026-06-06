package react

type reactor struct {
	cells []*cell
}
type cell struct {
	value    int
	callback map[int]func(int)
	compute  func() int
	r        *reactor
}

type canceler struct {
	id   int
	cell *cell
}

func (c *canceler) Cancel() {
	delete(c.cell.callback, c.id)
}

func (c *cell) Value() int {
	return c.value
}

func (c *cell) SetValue(value int) {
	c.value = value
	for _, computeCell := range c.r.cells {
		newValue := computeCell.compute()
		if newValue == computeCell.value {
			continue
		}
		computeCell.value = newValue
		for _, callback := range computeCell.callback {
			callback(computeCell.value)
		}
	}
}

func (c *cell) AddCallback(callback func(int)) Canceler {
	id := len(c.callback)
	c.callback[id] = callback
	return &canceler{cell: c, id: id}
}

func New() Reactor {
	return &reactor{cells: make([]*cell, 0)}
}

func (r *reactor) CreateInput(initial int) InputCell {
	c := cell{value: initial, r: r}
	return &c
}

func (r *reactor) CreateCompute1(dep Cell, compute func(int) int) ComputeCell {
	c := cell{
		value:    compute(dep.Value()),
		callback: make(map[int]func(int)),
		r:        r,
		compute:  func() int { return compute(dep.Value()) },
	}
	r.cells = append(r.cells, &c)
	return &c
}

func (r *reactor) CreateCompute2(dep1, dep2 Cell, compute func(int, int) int) ComputeCell {
	c := cell{
		value:    compute(dep1.Value(), dep2.Value()),
		callback: make(map[int]func(int)),
		r:        r,
		compute:  func() int { return compute(dep1.Value(), dep2.Value()) },
	}
	r.cells = append(r.cells, &c)
	return &c
}
