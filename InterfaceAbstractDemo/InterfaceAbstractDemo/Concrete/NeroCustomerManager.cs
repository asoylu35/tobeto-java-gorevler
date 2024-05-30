using InterfaceAbstractDemo.Abstracts;
using InterfaceAbstractDemo.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InterfaceAbstractDemo.Concrete
{
    internal class NeroCustomerManager : ICustomerService
    {
        public void Save(Customer customer)
        {
            throw new NotImplementedException();
        }
    }
}
