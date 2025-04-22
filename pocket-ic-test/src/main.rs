fn main() {
    println!("Hello, world!");
}

#[test]
fn test_pocket_ic() {
    use pocket_ic::PocketIc;

    let pocket_ic = PocketIc::new_from_existing_instance(
        url::Url::parse("http://localhost:8081").unwrap(),
        1,
        None,
    );
    println!("pocket ic id: {:?}", pocket_ic.instance_id());

    let canister_id = pocket_ic.create_canister();
    println!("canister id: {:?}", canister_id);
}
