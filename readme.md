ansible-playbook xxx.yml

1. MoveRemoteSQL.yml on remote, Move database on remote to tmp folder 
2. build app
3. cleanData.yml on localhost, clean database on local, and then init db, insert db
4. Deploy.yml on all
5. ReturnRemoteSQL.yml on remote, Move database on remote on tmp folder to amd_Data/StreamingAssets/ folder
6. CopyTRTfile.yml on remote 


## Docs

使用了 Ansible 來部署和管理多個步驟
1. 移動和管理遠端的資料庫。
2. 在本地清理資料並初始化資料庫。
3. 構建應用程式並部署到遠端。
4. 最後將資料庫和必要的檔案複製到遠端。


| **YML 文件**                | **描述**                                      | **任務**                                                                                                                                                                                                                      |
|----------------------------|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cleanData.yml`             | 刪除並創建 SQLite 資料庫、刪除資料夾中的圖像和日誌檔案 | 1. 檢查 SQLite 資料庫是否存在，若存在則刪除資料庫。<br> 2. 檢查應用資料夾是否存在，若存在則創建 SQLite 資料庫並執行 SQL 檔案（`drop.sql`、`user.sql`、`content.sql`、`insert.sql`）。<br> 3. 刪除 `FundusImage` 資料夾中的所有檔案。<br> 4. 刪除 `Logs` 資料夾中的所有檔案。 |
| `common_vars.yml`          | 定義共用變數                                 | 包含資料庫路徑、應用資料夾路徑、SQL 路徑、源檔案路徑等設定。                                                                                                                                                                      |
| `CopyRemoteDB.yml`         | 複製遠端資料庫檔案到本地                       | 1. 複製 `src_file_path` 的資料庫檔案到本地 `db_path`。                                                                                                                                                                           |
| `CopyTRTfile.yml`          | 複製 `trt.engine` 檔案到遠端                   | 1. 將 `trt.engine` 檔案複製到遠端的 `StreamingAssets` 資料夾。                                                                                                                                                                  |
| `deploy_dependency_services.yml` | 部署服務所需的腳本                          | 1. 刪除遠端目標目錄（如果存在）。<br> 2. 使用 `rsync` 同步檔案到遠端目標資料夾。                                                                                                                                                          |
| `Deploy.yml`               | 部署應用檔案到遠端                           | 1. 刪除遠端目標目錄。<br> 2. 複製本地應用檔案到遠端 `devBuild` 資料夾並設定擁有者與權限。                                                                                                                                          |
| `getSysInfo.yml`           | 獲取系統資訊                                 | 1. 列印主機名稱、LSB 信息、記憶體大小、NVIDIA 顯示卡資訊。                                                                                                                                                                      |
| `launcher.yml`             | 複製啟動器檔案到遠端                         | 1. 確保目標資料夾不存在，若存在則刪除。<br> 2. 確保目標資料夾存在並設定權限。<br> 3. 複製啟動器檔案到遠端目標資料夾。                                                                                                          |
| `MoveRemoteSQL.yml`        | 遠端移動資料庫至暫存資料夾                   | 1. 檢查 SQLite 資料庫是否存在，若存在則將資料庫複製到暫存資料夾。                                                                                                                                                            |
| `ReturnRemoteSQL.yml`      | 遠端移動資料庫檔案至 `StreamingAssets` 資料夾  | 1. 檢查 `tmp` 資料夾是否存在，若存在則將資料庫從 `tmp` 資料夾移至 `amd_Data/StreamingAssets` 資料夾。                                                                                                                   |
| **執行順序**               |                                               | 1. `MoveRemoteSQL.yml`（將遠端資料庫移至暫存資料夾）。<br> 2. `cleanData.yml`（清理本地資料庫並初始化）。<br> 3. `Deploy.yml`（部署應用到所有遠端機器）。<br> 4. `ReturnRemoteSQL.yml`（將資料庫從暫存資料夾移回 `StreamingAssets`）。<br> 5. `CopyTRTfile.yml`（複製 `trt.engine` 檔案到遠端）。 |

這些文件的執行順序和任務描述已經被清晰地列出，讓您能夠更好地理解各個步驟及其功能。