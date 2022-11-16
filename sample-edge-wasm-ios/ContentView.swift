//
//  ContentView.swift
//  sample-edge-wasm-ios
//
//  Created by Shota Shimazu on 2022/11/17.
//

import SwiftUI
import WasmInterpreter


struct WASMContainer {
    private let _vm: WasmInterpreter

    init() throws {
        _vm = try WasmInterpreter(module: WASMContainer.wasm)
    }

    func add(_ first: Int, _ second: Int) throws -> Int {
        Int(try _vm.call("add", Int32(first), Int32(second)) as Int32)
    }

    private static var wasm: [UInt8] {
        let base64 = "AGFzbQEAAAABBwFgAn9/AX8DAgEABwcBA2FkZAAACgkBBwAgACABags="
        return [UInt8](Data(base64Encoded: base64)!)
    }
}

struct ContentView: View {
    
    let mod = try! WASMContainer()

    @State var res = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Result: \(res)")
            Button("Run WASM") {
                res = try! mod.add(1, 1)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
