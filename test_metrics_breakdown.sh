#!/bin/bash
# Test individual metrics breakdown

echo "🔍 Testing AI Summarizer - Detailed Metrics Analysis"
echo "=================================================="
echo ""

# Test with technical documentation
TEXT="Model Context Protocol (MCP) adalah standar terbuka yang memungkinkan Large Language Models (LLM) untuk berinteraksi dengan data dan layanan eksternal dengan cara yang terpadu. MCP dirancang untuk mengatasi masalah fragmentasi dalam ekosistem AI. Setiap kali developer ingin mengintegrasikan sumber data baru ke dalam aplikasi AI, mereka harus membuat konektor khusus. MCP bekerja berdasarkan arsitektur klien-server yang terdiri dari beberapa komponen utama: Host (Aplikasi AI): Aplikasi yang menggunakan LLM, seperti agen AI atau chatbot, untuk melakukan tugas. Klien MCP: Protokol yang menghubungkan host dengan server MCP. Server MCP: Program ringan yang mengekspos data dan fungsionalitas dari sistem eksternal, seperti database perusahaan atau API pihak ketiga. Layanan Eksternal: Sumber data asli, seperti file, database, atau layanan API yang datanya diakses oleh server MCP."

echo "📝 Input Text Length: ${#TEXT} characters"
echo ""
echo "Calling ai_summarize..."
echo ""

dfx canister call encrypted-notes-backend ai_summarize "(
  record {
    text = \"$TEXT\";
    language = \"id\";
    content_type = \"technical\";
  }
)" --query 2>/dev/null | head -50

echo ""
echo "✅ Analysis complete!"
