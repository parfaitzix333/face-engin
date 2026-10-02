"""
db_config.py
============

Configuration MySQL centralisée.
Un seul endroit à modifier si on change de serveur/base.
"""

DB_CONFIG = {
    "host":     "127.0.0.1",   # 127.0.0.1 et NON localhost (XAMPP socket)
    "port":     3306,
    "user":     "root",
    "password": "",            # vide en dev local (XAMPP par défaut)
    "database": "bd_arsp",
    "charset":  "utf8mb4",
}