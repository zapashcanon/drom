(**************************************************************************)
(*                                                                        *)
(*    Copyright 2020 OCamlPro & Origin Labs                               *)
(*                                                                        *)
(*  All rights reserved. This file is distributed under the terms of the  *)
(*  GNU Lesser General Public License version 2.1, with the special       *)
(*  exception on linking described in the file LICENSE.                   *)
(*                                                                        *)
(**************************************************************************)

let buffer b s =
  for i = 0 to String.length s - 1 do
    match s.[i] with
    | c
      when c >= ' ' && c <= '~' && c <> '\\' && c <> '"' && c <> '\n'
           && c <> '\r' && c <> '\t' ->
        Buffer.add_char b c
    | c -> Printf.bprintf b "&#%d;" (int_of_char c)
  done

let string s =
  let b = Buffer.create (String.length s + 11) in
  buffer b s;
  Buffer.contents b