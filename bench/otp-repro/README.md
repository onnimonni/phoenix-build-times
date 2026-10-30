How the OTP master compiler crash was reduced to `norm_number_crash.erl`:

1. `to_erl.exs` (run in the app with the patched OTP) dumps the `Decimal` module's Erlang
   abstract code from its debug info into a term file.
2. `minimize.escript` (run with the *unpatched* OTP) removes functions and clauses while
   `compile:forms/2` keeps crashing in `beam_types:norm_number/1`: 16 functions were left.
3. The rest was reduced by hand to `norm_number_crash.erl`.

```sh
erlc norm_number_crash.erl   # unpatched OTP master 4ba5448: internal error in pass beam_validator_strong
```
