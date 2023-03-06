package std_types;

    typedef logic bool;

    localparam U4 = 4;
    localparam U8 = 8;
    localparam U16 = 16;
    localparam U32 = 32;
    localparam U64 = 64;
    localparam U128 = 128;

    typedef logic [U4 - 1 : 0] u4;
    typedef logic [U8 - 1 : 0] u8;
    typedef logic [U16 - 1 : 0] u16;
    typedef logic [U32 - 1 : 0] u32;
    typedef logic [U64 - 1 : 0] u64;
    typedef logic [U128 - 1 : 0] u128;

endpackage