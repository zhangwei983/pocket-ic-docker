use candid::{encode_one, Principal};
use pocket_ic::{PocketIc, PocketIcBuilder};

// 2T cycles
const INIT_CYCLES: u128 = 2_000_000_000_000;

fn main() {
    // Initialize pocket-ic.
    let pic = PocketIcBuilder::new()
        .with_server_url(url::Url::parse("http://0.0.0.0:8081").unwrap())
        .with_application_subnet()
        .build();
    println!("pocket ic id: {:?}", pic.instance_id());

    // Create canister.
    let canister_id = pic.create_canister();
    println!("canister id: {:?}", canister_id.to_text());

    // Install canister.
    pic.add_cycles(canister_id, INIT_CYCLES);
    pic.install_canister(canister_id, counter_wasm(), vec![], None);

    // Make some calls to the canister.
    let reply = call_counter_canister(&pic, canister_id, "read");
    println!("reply: {:?}", reply);
    assert_eq!(reply, vec![0, 0, 0, 0]);
    let reply = call_counter_canister(&pic, canister_id, "write");
    println!("reply: {:?}", reply);
    assert_eq!(reply, vec![1, 0, 0, 0]);
    let reply = call_counter_canister(&pic, canister_id, "write");
    println!("reply: {:?}", reply);
    assert_eq!(reply, vec![2, 0, 0, 0]);
    let reply = call_counter_canister(&pic, canister_id, "read");
    println!("reply: {:?}", reply);
    assert_eq!(reply, vec![2, 0, 0, 0]);
}

// Call a method on the counter canister as the anonymous principal.
fn call_counter_canister(pic: &PocketIc, canister_id: Principal, method: &str) -> Vec<u8> {
    pic.update_call(
        canister_id,
        Principal::anonymous(),
        method,
        encode_one(()).unwrap(),
    )
    .expect("Failed to call counter canister")
}

fn counter_wasm() -> Vec<u8> {
    const COUNTER_WAT: &str = r#"
    (module
        (import "ic0" "msg_reply" (func $msg_reply))
        (import "ic0" "msg_reply_data_append" (func $msg_reply_data_append (param i32 i32)))
        (func $write
            (i32.store (i32.const 0) (i32.add (i32.load (i32.const 0)) (i32.const 1)))
            (call $read))
        (func $read
            (call $msg_reply_data_append
                (i32.const 0) ;; the counter from heap[0]
                (i32.const 4)) ;; length
            (call $msg_reply))
        (memory $memory 1)
        (export "canister_query read" (func $read))
        (export "canister_update write" (func $write))
    )"#;
    wat::parse_str(COUNTER_WAT).unwrap()
}
