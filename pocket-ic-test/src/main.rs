use pocket_ic::PocketIcBuilder;

fn main() {
    let pic = PocketIcBuilder::new()
        .with_server_url(url::Url::parse("http://0.0.0.0:8081").unwrap())
        .with_application_subnet()
        .build();
    println!("pocket ic id: {:?}", pic.instance_id());

    let canister_id = pic.create_canister();
    println!("canister id: {:?}", canister_id.to_text());
}
