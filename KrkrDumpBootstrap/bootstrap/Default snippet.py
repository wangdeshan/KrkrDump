import re
import ida_bytes
import ida_segment
import ida_dbg
import ida_funcs
import idautils

def find_byte_sequence(pattern,namebase="Func"):
    count = 0

    seg = idaapi.get_first_seg()  # 获取第一个段
    while seg:
        # print(f"Segment: {idaapi.get_segm_name(seg)}")
        # print(f"  Start: 0x{seg.start_ea:X}")
        # print(f"  End:   0x{seg.end_ea:X}")
        print(f"搜索段{idaapi.get_segm_name(seg)}")
        start = seg.start_ea  # 获取段起始地址
        end = seg.end_ea  # 获取段结束地址
        data = ida_bytes.get_bytes(start, end - start)

        pattern_len = len(pattern)

        for i in range(len(data) - pattern_len + 1):
            match = True
            for j in range(pattern_len):
                if pattern[j] != 0x2A and data[i + j] != pattern[j]:  # 0x2A 作为通配符
                    match = False
                    break
            if match:
                count+=1
                addr = start + i
                print(f"匹配地址：0x{addr:X}")
                print(f"添加断点：0x{addr:X}")
                ida_dbg.add_bpt(addr)

                func = ida_funcs.get_func(addr)
                if func:
                    func_start = func.start_ea
                    new_name = f"{namebase}_{func_start:X}"  # 生成唯一名称
                    idaapi.set_name(func_start, new_name, idaapi.SN_NOWARN)
                    print(f"函数 0x{func_start:X} 重命名为 {new_name}")
                else:
                    print(f"[-] 地址 0x{addr:X} 不在任何函数内")

        seg = idaapi.get_next_seg(seg.start_ea)  # 获取下一个段

    if count == 0:
        print("未找到 "+str(pattern))




seq1 = b"\x55\x8B\xEC\x83\xEC\x50\xFF\x71\x08\xC7\x45\x2A\x2A\x2A\x2A\x2A\xFF\x71\x04\x8D\x4D\xB0"
seq2 = b"\x55\x8B\xEC\x81\xEC\x2A\x2A\x2A\x2A\xA1\x2A\x2A\x2A\x2A\x33\xC5\x89\x45\xFC\x8B\x45\x08\x56\x8B\x75\x10\x57"

find_byte_sequence(seq1,"Hx_PathHash")
find_byte_sequence(seq2,"Hx_NameHash")
