#                                                                       |mudar esse ip e porta  |
# comandos: venv/Scripts/activate, uvicorn app.main:app --reload --host 192.168.40.14 --port 8000
#
from typing import List
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from .database import SessionLocal, engine
from . import crud, models, schemas

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/items/", response_model=List[schemas.Item])
def list_items(db: Session = Depends(get_db)):
    return crud.get_items(db=db)

@app.post("/items/", response_model=schemas.Item)
def create_item(item: schemas.ItemCreate, db: Session = Depends(get_db)):
    return crud.create_item(db=db, item=item)

@app.put("/items/{id}/", response_model=schemas.Item)
def update_item(item: schemas.ItemUpdate, id: int = id, db: Session = Depends(get_db)):
    return crud.update_item(db=db, item=item, id=id)

@app.delete("/items/{id}/")
def delete_item(id: int = id, db: Session = Depends(get_db)):
    crud.delete_item(db=db, id=id)
    return {}

@app.post("/items/{id}/purchase/", response_model=schemas.Item)
def purchase_item(id: int = id, db: Session = Depends(get_db)):
    return crud.purchase_item(db=db, id=id, purchased=True)

@app.post("/items/{id}/unpurchase/", response_model=schemas.Item)
def unpurchase_item(id: int = id, db: Session = Depends(get_db)):
    return crud.purchase_item(db=db, id=id, purchased=False)
