using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Enum
{
    public class Enums
    {
        public enum TipIzazov
        {
            Fizicki = 1,
            Edukativni = 2,
            Sportski = 3
        }
        public enum StatusIzazova
        {
            Prihvacen = 1,
            Trenutno = 2,
            Zavrsen = 3,
            Odustao = 4
        }
        public enum StatusPeera
        {
            Poslan = 1,
            Prihvacen = 2,
            Zavrsen = 3
        }
    }
}
