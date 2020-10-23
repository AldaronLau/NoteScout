//! This example demonstrates salting the password in the database.

fn main() {
    let name = "guest".to_string();
    let salt: u64 = rand::random();
    let join = format!("{}{:X}", name, salt);
    println!("Hashing: '{}'", join);
    let hash = hmac_sha256::Hash::hash(join.as_bytes());
    print!("Hashed: '");
    for byte in hash.iter() {
        print!("{:X}", byte);
    }
    println!("'");
}
