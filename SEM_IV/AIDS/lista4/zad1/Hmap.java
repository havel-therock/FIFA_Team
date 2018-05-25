import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Hmap extends DataStructure {
	private Object[] table;
	public static int arraySize = 31;
	public static int toLink = 100;
	public static int toRBT = 80;

	public Hmap() {

		table = new Object[arraySize];

	}

	public void insert(String val) {
		int pos = myhash(val);
		size++;
		if (table[pos] == null || table[pos].getClass() == MyList.class) {
			insertLink(val);
		} else {
			RBT x = (RBT) table[pos];
			x.insert(val);
			table[pos] = x;
		}
	}

	private void insertLink(String val) {
		int pos = myhash(val);
		MyList nptr = new MyList(val);

		if (table[pos] == null) {
			table[pos] = nptr;
		} else {
			nptr.next = (MyList) table[pos];
			table[pos] = nptr;
			MyList x = nptr;
			while (x != null) {
				nptr.size++;
				x = x.next;
			}
			if (nptr.size > toRBT) {
				table[pos] = (RBT) linkToRbt(nptr);
			}
		}
	}

	public void delete(String val) {
		int pos = myhash(val);
		if (table[pos] == null) {
			return;
		}
		size--;
		if (table[pos].getClass() == MyList.class) {
			deleteLink(val);
		} else {
			RBT x = (RBT) table[pos];
			x.delete(val);
			table[pos] = x;
			if (x.size < toLink) {
				rbtToLink(x);
			}
		}
	}

	private void deleteLink(String val) {
		int pos = myhash(val);
		MyList start = (MyList) table[pos];
		MyList end = start;
		if (start.data.equals(val)) {
			table[pos] = start.next;
			return;
		}
		while (end.next != null && !end.next.data.equals(val)) {
			end = end.next;
		}
		if (end.next == null) {
			System.out.println("\nNo element\n");
			return;
		}
		if (end.next.next == null) {
			end.next = null;
			return;
		}
		end.next = end.next.next;
		table[pos] = start;
	}

	private int myhash(String wordToHash) {
		int hashKeyValue = 0;

		for (int i = 0; i < wordToHash.length(); i++) {
			int charCode = wordToHash.toLowerCase().charAt(i) - 96;
			hashKeyValue = (hashKeyValue * 27 + charCode) % arraySize;
		}
		return hashKeyValue;

	}

	public void find(String wordToFind) {
		int pos = myhash(wordToFind);
		if (table[pos] == null) {
			System.out.println("0");
			return;
		}
		if (table[pos].getClass() == MyList.class) {
			findLink(wordToFind);
		} else {
			RBT x = (RBT) table[pos];
			System.out.println(x.findx(wordToFind));
		}
	}

	public void findLink(String wordToFind) {
		int hashKey = myhash(wordToFind);
		if (findString(wordToFind, (MyList) table[hashKey])) {
			System.out.println("1");
		} else {
			System.out.println("0");
		}
	}

	private boolean findString(String wordToFind, MyList x) {
		while (x != null) {
			if (x.data.equals(wordToFind)) {
				return true;
			} else {
				x = x.next;
			}
		}
		return false;

	}

	private RBT linkToRbt(MyList x) {
		RBT rbt = new RBT();
		while (x != null) {
			rbt.insert(x.data);
			x = x.next;
		}
		return rbt;
	}

	private void rbtToLink(RBT x) {
		String s = x.inorderX();
		String[] words = s.split(" ");
		int hashKey = myhash(words[0]);
		table[hashKey] = null;
		for (String w : words) {
			insert(w);
		}

	}

	public void load(String f) {
		// System.out.println("zz");
		BufferedReader abc;
		try {
			abc = new BufferedReader(new FileReader(f));
			String text = "";

			String line;
			while ((line = abc.readLine()) != null) {
				text += line;
				// System.out.println();
			}
			String[] strings;
			strings = text.split("\\s+");
			for (int i = 0; i < strings.length; i++) {
				// System.out.println("OO " + strings[i]);
				insert(strings[i].replaceAll("[^a-zA-Z]", ""));
			}
			abc.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

class MyList {

	MyList next;
	String data;
	int size = 0;

	public MyList(String x) {
		data = x;
		next = null;
	}
}
