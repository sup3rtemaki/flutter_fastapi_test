from typing import List
from pydantic import BaseModel

class ItemBase(BaseModel):
    name: str
    category: str
    purchased: bool

class ItemCreate(ItemBase):
    pass

class ItemUpdate(ItemBase):
    pass

class Item(ItemBase):
    id: int

    class Config:
        orm_mode = True