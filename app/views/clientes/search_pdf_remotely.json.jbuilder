json.array!(@cliente_collection_pdfs) do |pdf|
  json.extract! pdf, :id, :anotacoes, :cliente_id
  json.url pdf.pdf.url

  json.set! :data, pdf.data.strftime("%d/%m/%Y")
end