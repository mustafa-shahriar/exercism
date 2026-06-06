#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    if first_list == second_list {
        return Comparison::Equal;
    }

    if first_list.is_empty() {
        return Comparison::Sublist;
    }

    if second_list.is_empty() {
        return Comparison::Superlist;
    }

    if second_list
        .windows(first_list.len())
        .any(|window| window == first_list)
    {
        return Comparison::Sublist;
    }

    if first_list
        .windows(second_list.len())
        .any(|window| window == second_list)
    {
        return Comparison::Superlist;
    }

    Comparison::Unequal
}
