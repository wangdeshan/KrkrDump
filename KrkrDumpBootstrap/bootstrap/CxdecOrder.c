//----- (654E8610) --------------------------------------------------------
char __thiscall sub_654E8610(int this, const char * a2) {
    v8 = cxrandom & 7;
    if (v8 ==  * v7) // 0
        result = sub_654E8B60((_DWORD * )this, 0xF7, 0xD0);
    if (v8 == v7[1]) // 2
        result = sub_654E8B60((_DWORD * )this, 0xF7, 0xD8);
    if (v8 == v7[2]) // 3
        result = sub_654E8B30((_DWORD * )this, 0x40);
    if (v8 == v7[3]) // 1
        result = sub_654E8B30((_DWORD * )this, 0x48);
    if (v8 == v7[4]) { // 5
        if (!sub_654E8B30((_DWORD * )this, 0x53)
             || !sub_654E8B60((_DWORD * )this, 0x89, 0xC3)
             || !sub_654E8C50((_DWORD * )this, 0x81, 0xE3, 0xAA, 0xAA, 0xAA, 0xAA)
             || !sub_654E8BF0((_DWORD * )this, 0x25, 0x55, 0x55, 0x55, 0x55)
             || !sub_654E8B60((_DWORD * )this, 0xD1, 0xEB)
             || !sub_654E8B60((_DWORD * )this, 0xD1, 0xE0)
             || !sub_654E8B60((_DWORD * )this, 9, 0xD8)) {
            return 0;
        }
    }
    if (v8 == v7[5]) // 6
        result = sub_654E8B30((_DWORD * )this, 0x35);
    if (v8 != v7[6]) { // 7
        result = sub_654E8B30((_DWORD * )this, 5);
        else if (!sub_654E8B30((_DWORD * )this, 0x2D))
    }
    if (v8 == v7[7]) { // 4
        if (!sub_654E8B30((_DWORD * )this, 0xBE)
             || !sub_654E8CC0((_DWORD * )this,  * (_DWORD * )(this + 0xC))
             || !sub_654E8B30((_DWORD * )this, 0x25)
             || !sub_654E8CC0((_DWORD * )this, 0x3FF)) {
            return 0;
        }
        result = sub_654E8BA0((_DWORD * )this, 0x8B, 4, 0x86);
    }
}

//----- (66048000) --------------------------------------------------------
char __thiscall sub_66048000(int this, const char * a2) {
    v11 = cxrandom % 6;
    v12 =  * (_BYTE ** )(this + 0x2C);
    if ((_BYTE)v11 == v12[8]) // 2
        result = sub_66048B60((_DWORD * )this, 0x01, 0xD8);
    if ((_BYTE)v11 == v12[9]) // 5
        result = sub_66048B60((_DWORD * )this, 0x29, 0xD8);
    if ((_BYTE)v11 != v12[0xA]) { // 3
        if (!sub_66048B60((_DWORD * )this, 0xF7, 0xD8))
            result = sub_66048B60((_DWORD * )this, 1, 0xD8);
    }
    if ((_BYTE)v11 == v12[0xB]) // 4
        result = sub_66048BA0((_DWORD * )this, 0xF, 0xAF, 0xC3);
    if ((_BYTE)v11 == v12[0xC]) { // 1
        if (!sub_66048B30((_DWORD * )this, 0x51)
             || !sub_66048B60((_DWORD * )this, 0x89, 0xD9)
             || !sub_66048BA0((_DWORD * )this, 0x83, 0xE1, 0xF)
             || !sub_66048B60((_DWORD * )this, 0xD3, 0xE0)) {
            return 0;
        }
        result = sub_66048B30((_DWORD * )this, 0x59);
    }
    if ((_BYTE)v11 == v12[0xD]) { // 0
        if (!sub_66048B30((_DWORD * )this, 0x51)
             || !sub_66048B60((_DWORD * )this, 0x89, 0xD9)
             || !sub_66048BA0((_DWORD * )this, 0x83, 0xE1, 0xF)
             || !sub_66048B60((_DWORD * )this, 0xD3, 0xE8)) {
            return 0;
        }
        result = sub_66048B30((_DWORD * )this, 0x59);
    }
}

//----- (10018410) --------------------------------------------------------
char __thiscall sub_10018410(int this) {
    v4 = cxrandom % 3;
    v5 =  * (_BYTE ** )(this + 0x2C);
    if (v4 == v5[0xE]) // 0
         * (_BYTE * )(v6 +  * (_DWORD * )this) = 0xB8;
    if (v4 == v5[0xF]) { // 1
         * (_BYTE * )(v13 +  * (_DWORD * )this) = 0x8B;
         * (_BYTE * )( * (_DWORD * )this +  * (_DWORD * )(this + 4) + 1) = 0xC7;
    }
    if (v4 == v5[0x10]) {// 2
        if (!sub_10018B30((_DWORD * )this, 0xBE))
            result = sub_10018B60((_DWORD * )this, 0x8B, 0x86);
        v17 = sub_10018B10((unsigned int * )this) & 0x3FF;
        result = sub_10018CC0((_DWORD * )this, 4 * v17);
    }
}
