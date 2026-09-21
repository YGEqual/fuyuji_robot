# CURL 示例与文档链接规范

## 各环境 CURL 示例规范

**为什么**：方便直接复制粘贴调用，减少手动拼接的出错率。

**必须包含的环境**（按顺序）：本地环境 → QA 环境 → 生产环境（如果有）

**格式要求**：
1. 每个环境单独一个代码块，标注环境名
2. 参数要填真实可用的示例值（占位符代替敏感字段）
3. Header 要完整（Authorization、Content-Type 等）
4. Authorization 直接写上真实 token，不要用占位符
5. 复杂 JSON Body 要格式化

**示例模板**：

```markdown
## 调用示例

### 本地环境

\`\`\`bash
curl -X POST 'http://localhost:8080/api/xxx' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: 2bfdb73a4c8a47cca5cf0f03873b52fe' \
  -d '{ "param1": "value1", "param2": 10 }'
\`\`\`

### QA 环境

\`\`\`bash
curl -X POST 'http://xxx.qa.17usoft.com/api/xxx' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: 2bfdb73a4c8a47cca5cf0f03873b52fe' \
  -d '{ "param1": "value1", "param2": 10 }'
\`\`\`
```

---

## 文档链接规范

在文档中引用其他 `*_DOC.md` 文档时：

1. **必须使用在线可点击的 URL**，而不是相对路径。
2. **使用当前应用对应的 QA 环境地址**。
3. **链接格式规则**：
   - doc 参数必须加 `doc/` 前缀
   - 中文路径必须 URL 编码
   - 文档名不带 `_DOC` 后缀

### 各应用的文档地址格式

| 应用/仓库 | QA 环境标识 | 文档 URL 格式 |
|-----------|-------------|---------------|
| dt_robot / arsenal-ai-deeptrip | `/deeptrip_qa{N}/` | `https://dtgw.qa.ly.com/deeptrip_qa{N}/api-doc-ui/index.html?doc=doc%2F{group}%2F{simpleName}` |
| arsenal-service-ai-dataset | `.qa{N}.17usoft.com` | `http://arsenal-ai-dataset.qa{N}.17usoft.com/api-doc-ui/index.html?doc=doc%2F{group}%2F{simpleName}` |
| arsenal-ai-deeptrip-marketing | `.qa{N}.17usoft.com` | `http://arsenal-ai-deeptrip-marketing.qa{N}.17usoft.com/api-doc-ui/index.html?doc=doc%2F{group}%2F{simpleName}` |
| arsenal-service-ai-mcp | `.qa{N}.17usoft.com` | `http://arsenal-ai-service-mcp.qa{N}.17usoft.com/api-doc-ui/index.html?doc=doc%2F{group}%2F{simpleName}` |
| agent-b101 | `.qa{N}.17usoft.com` | `http://arsenal-ai-agent-deeptrip.qa{N}.17usoft.com/api-doc-ui/index.html?doc=doc%2F{group}%2F{simpleName}` |

### 反例

```markdown
# 错误1：使用相对路径
详细清单：[依赖总览](../系统迭代/xxx_DOC.md)

# 错误2：doc 参数没有 doc/ 前缀
https://dtgw.qa.ly.com/deeptrip_qa6/api-doc-ui/index.html?doc=系统迭代/xxx

# 错误3：链接末尾带了 _DOC
https://dtgw.qa.ly.com/deeptrip_qa6/api-doc-ui/index.html?doc=doc%2F系统迭代%2Fxxx_DOC

# 错误4：中文没有 URL 编码
https://dtgw.qa.ly.com/deeptrip_qa6/api-doc-ui/index.html?doc=doc/系统迭代/依赖总览
```

### 正例

```markdown
# dt-main 仓库引用文档（qa6 环境）
详细说明见：[DeepTrip 风控安全说明](https://dtgw.qa.ly.com/deeptrip_qa6/api-doc-ui/index.html?doc=doc%2Fdeeptrip%E6%9E%B6%E6%9E%84%E6%A2%B3%E7%90%86%2F%E6%B5%81%E7%A8%8B%E6%A2%B3%E7%90%86%2Fdeeptrip%E9%A3%8E%E6%8E%A7%E5%AE%89%E5%85%A8%E8%AF%B4%E6%98%8E)

# dt-dataset 仓库引用文档（默认 qa 环境）
机票接口：[国内机票资源](http://arsenal-ai-dataset.qa.17usoft.com/api-doc-ui/index.html?doc=doc%2F%E6%9E%B6%E6%9E%84%E6%A2%B3%E7%90%86%2F%E8%B5%84%E6%BA%90%E7%9B%B8%E5%85%B3%2F%E4%BE%9D%E8%B5%96%E7%9A%84%E5%A4%96%E9%83%A8%E5%9B%BD%E5%86%85%E6%9C%BA%E7%A5%A8%E6%8E%A5%E5%8F%A3%E8%B5%84%E6%BA%90)
```
