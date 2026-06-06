pub fn main() {}

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let mut vec: Vec<Vec<char>> = minefield.iter().map(|l| l.chars().collect()).collect();
    let dir: [(isize, isize); 8] = [
        (-1, 0),
        (0, 1),
        (1, 0),
        (0, -1),
        (-1, -1),
        (-1, 1),
        (1, 1),
        (1, -1),
    ];
    let num_rows = vec.len();
    let num_cols = vec.first().map_or(0, |line| line.len());

    for x in 0..num_rows {
        for y in 0..num_cols {
            if vec[x][y] != ' ' {
                continue;
            }

            let mut count: u8 = 0;
            for (dx, dy) in dir {
                let (nx, ny) = (x as isize + dx, y as isize + dy);
                if nx < 0 || ny < 0 || nx >= num_rows as isize || ny >= num_cols as isize {
                    continue;
                }
                if vec[nx as usize][ny as usize] == '*' {
                    count += 1;
                }
            }
            if count != 0 {
                vec[x][y] = (count + b'0') as char;
            }
        }
    }

    vec.into_iter().map(|l| l.into_iter().collect()).collect()
}
