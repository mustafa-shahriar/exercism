pub fn annotate(garden: &[&str]) -> Vec<String> {
    if garden.is_empty() {
        return vec![];
    }
    let row = garden.len();
    let col = garden[0].len();
    let space = b' ';
    let star = b'*';
    let grid: Vec<Vec<u8>> = garden.iter().map(|r| r.bytes().collect()).collect();
    let mut result = vec![vec![' '; col]; row];

    for i in 0..row {
        for j in 0..col {
            if grid[i][j] != space {
                result[i][j] = '*';
                continue;
            }
            let left = j > 0;
            let right = j + 1 < col;
            let up = i > 0;
            let down = i + 1 < row;
            let mut count = 0;

            if left && grid[i][j - 1] == star {
                count += 1;
            }
            if right && grid[i][j + 1] == star {
                count += 1;
            }
            if down && grid[i + 1][j] == star {
                count += 1;
            }
            if up && grid[i - 1][j] == star {
                count += 1;
            }
            if right && up && grid[i - 1][j + 1] == star {
                count += 1;
            }
            if left && up && grid[i - 1][j - 1] == star {
                count += 1;
            }
            if right && down && grid[i + 1][j + 1] == star {
                count += 1;
            }
            if left && down && grid[i + 1][j - 1] == star {
                count += 1
            }
            if count == 0 {
                result[i][j] = ' ';
            } else {
                result[i][j] = char::from_digit(count, 10).unwrap();
            }
        }
    }
    return result
        .into_iter()
        .map(|r| r.into_iter().collect())
        .collect();
}
