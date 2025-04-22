fn main() {
    println!("Hello, world!");
}

#[test]
fn test_pocket_ic() {
    use pocket_ic::PocketIcBuilder;

    let pic = PocketIcBuilder::new()
        .with_server_url(url::Url::parse("http://172.31.224.1:8081").unwrap())
        .with_application_subnet()
        .build();
    println!("pocket ic id: {:?}", pic.instance_id());

    let canister_id = pic.create_canister();
    println!("canister id: {:?}", canister_id);
}
