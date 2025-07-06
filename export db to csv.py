#ekspor file ke csv

import sqlite3
import pandas as pd
import os

# Koneksi ke SQLite
conn = sqlite3.connect('sql-murder-mystery.db')
cursor = conn.cursor()

# Folder output khusus
output_dir = 'D:/SQL Murder Mystery/exported_csv_proper'
os.makedirs(output_dir, exist_ok=True)

# Ekspor semua tabel dengan CSV aman untuk PostgreSQL
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [row[0] for row in cursor.fetchall()]

for table in tables:
    print(f"➤ Mengekspor tabel: {table}")
    df = pd.read_sql_query(f"SELECT * FROM {table}", conn)

    df.to_csv(
    f"{output_dir}/{table}.csv",
    index=False,
    quoting=1,  # csv.QUOTE_ALL
    quotechar='"',
    escapechar='\\'
)

conn.close()
print("\n✅ Semua tabel berhasil diekspor ulang dengan aman.")



# karena  gabisa copy ke PostgrateSQL jadi beberapa disesuaikann termasuk menghapus data yang emang ga macth satu sama lain

import pandas as pd
person = pd.read_csv('D:/SQL Murder Mystery/exported_csv_proper/person.csv')
income = pd.read_csv('D:/SQL Murder Mystery/exported_csv_proper/income.csv')
# Hanya ambil baris yang ssn-nya ada di income
filtered_person = person[person['ssn'].isin(income['ssn'])]
# Simpan hasilnya
filtered_person.to_csv('D:/SQL Murder Mystery/exported_csv_proper/person_filtered.csv', index=False)




import pandas as pd
# Load person dan checkin
person = pd.read_csv('D:/SQL Murder Mystery/exported_csv_proper/person.csv')
checkin = pd.read_csv('D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin.csv')
# Filter hanya yang person_id-nya valid
checkin_filtered = checkin[checkin['person_id'].isin(person['id'])]
# Overwrite file
checkin_filtered.to_csv('D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin.csv', index=False)



import pandas as pd
# Baca file (deteksi kolom dari header)
df = pd.read_csv('D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin.csv')
# Simpan ulang tanpa gangguan
df.to_csv('D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin_clean.csv', index=False)
input_path = 'D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin.csv'
output_path = 'D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin_clean.csv'
with open(input_path, 'r', encoding='utf-8') as infile, open(output_path, 'w', encoding='utf-8') as outfile:
    for line in infile:
        # Hapus ;; di akhir baris dan newline
        clean_line = line.rstrip().removesuffix(';;')
        outfile.write(clean_line + '\n')




import pandas as pd
# Load file yang udah lo upload
event_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin_FIXED.csv", dtype=str)
person_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/person_filtered.csv", dtype=str)
# Ambil ID yang valid aja
valid_ids = set(person_df['id'].astype(str).str.strip())
# Filter hanya person_id yang valid
cleaned_df = event_df[event_df['person_id'].isin(valid_ids)]
# Simpan file akhir
cleaned_df.to_csv("D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin_FINAL.csv", index=False)



import re
import csv
# Path file input dan output
input_file = r"D:/SQL Murder Mystery/exported_csv_proper/interview.csv"
output_file = r"D:/SQL Murder Mystery/exported_csv_proper/interview_cleaned.csv"
# Proses pembersihan
with open(input_file, "r", encoding="utf-8") as infile, open(output_file, "w", newline="", encoding="utf-8") as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["person_id", "transcript"])
    for line in infile:
        # Hapus karakter aneh
        line = line.strip().replace(';;', '').replace('""', '"')
        # Deteksi pola person_id dan transcript
        match = re.match(r'^"?(\d+)"?\s*,\s*"?(.+?)"?$', line)
        if match:
            person_id = match.group(1)
            transcript = match.group(2)
            writer.writerow([person_id, transcript])



import pandas as pd
# Load kedua file
interview_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/interview_cleaned.csv", dtype=str)
person_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/person_filtered.csv", dtype=str)
# Ambil hanya person_id yang valid
valid_ids = set(person_df['id'].astype(str).str.strip())
# Filter berdasarkan ID valid
final_df = interview_df[interview_df['person_id'].isin(valid_ids)]
# Simpan file akhir
final_df.to_csv("D:/SQL Murder Mystery/exported_csv_proper/interview_FINAL.csv", index=False)



import pandas as pd
# Load kedua file
member_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_member.csv", dtype=str)
person_df = pd.read_csv("D:/SQL Murder Mystery/exported_csv_proper/person_filtered.csv", dtype=str)
# Ambil hanya person_id yang valid
valid_ids = set(person_df['id'].astype(str).str.strip())
# Filter berdasarkan ID valid
final_df = member_df[member_df['person_id'].astype(str).isin(valid_ids)]
# Simpan file akhir
final_df.to_csv("D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_member_FINAL.csv", index=False)



import pandas as pd
# Path file
checkin_path = r"D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_check_in.csv"
member_path = r"D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_member_FINAL.csv"
output_path = r"D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_check_in_FINAL.csv"
# Load data
checkin_df = pd.read_csv(checkin_path, dtype=str)
member_df = pd.read_csv(member_path, dtype=str)
# Ambil hanya membership_id yang valid
valid_memberships = set(member_df['id'].astype(str).str.strip())
filtered_df = checkin_df[checkin_df['membership_id'].astype(str).isin(valid_memberships)]
# Simpan ke file baru
filtered_df.to_csv(output_path, index=False)
print("✅ File bersih berhasil disimpan:", output_path)
