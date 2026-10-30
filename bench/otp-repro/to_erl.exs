# Writes compilable Erlang source of a compiled Elixir module (from its debug info):
# without types/specs/file attributes or dev-only compiler options, renamed to OUT_MODULE
[module, out_module, out] = System.argv()
module = String.to_atom("Elixir." <> module)
{:ok, {_, [debug_info: {:debug_info_v1, backend, data}]}} = :beam_lib.chunks(:code.which(module), [:debug_info])
{:ok, forms} = backend.debug_info(:erlang_v1, module, data, [])

forms =
  forms
  |> Enum.reject(&match?({:attribute, _, kind, _} when kind in [:type, :spec, :opaque, :callback, :file, :export_type], &1))
  |> Enum.map(fn
    {:attribute, l, :module, _} -> {:attribute, l, :module, String.to_atom(out_module)}
    {:attribute, l, :compile, opts} -> {:attribute, l, :compile, Enum.reject(List.wrap(opts), &(is_atom(&1) and String.starts_with?(Atom.to_string(&1), "no_")))}
    form -> form
  end)

File.write!(out, :erlang.term_to_binary(forms))
