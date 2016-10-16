 
//LiveLock pavyzdys
//jeigu sekmingai uzbaige vadinasi neivyko
//jeigu uztrigo vadinasi ivyko. CTRL+C nutraukti programa
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
class LiveLock
{
	public static void main(String[] args)
	{
		Lock p = new ReentrantLock();
		Lock n = new ReentrantLock();
		Thread t1 = new Thread(new One(p,n));
		Thread t2 = new Thread(new Two(n,p));
		t1.start();
		t2.start();
	}
}

class One implements Runnable
{
	Lock p;
	Lock n;

	public One(Lock p, Lock n)
	{
		this.p = p;
		this.n = n;
	}

	public void run()
	{
		for(int i=0; i<100; i++)
		{
			synchronized(p)
			{
				while(Thread.holdsLock(n))
				{
					try 
					{
						p.unlock();
						wait(1);
						p.lock();
					}
					catch(InterruptedException e){}
				}

				synchronized(n)
				{
					System.out.println("p--n");
				}
			}
		}
	}
}

class Two implements Runnable
{
	Lock p;
	Lock n;

	public Two(Lock n, Lock p)
	{
		this.p = p;
		this.n = n;
	}

	public void run()
	{
		for(int i=0; i<100; i++)
		{
			synchronized(n)
			{
				while(Thread.holdsLock(p))
				{
					try
					{
						n.lock();
						wait(1);
						n.unlock();
					}
					catch(InterruptedException e){}
				}

				synchronized(p)
				{
					System.out.println("n--p");
				}
			}
		}
	}
}
